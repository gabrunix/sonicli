#!/usr/bin/env bash

SONICLI_SOCKET="${TMPDIR:-/tmp}/sonicli-mpv-${USER:-user}-$$.sock"
SONICLI_MPV_PID=''

sonicli_mpv_send() {
  [[ -S "$SONICLI_SOCKET" ]] || return 1
  printf '%s\n' "$1" | socat - "$SONICLI_SOCKET" >/dev/null 2>&1
}

sonicli_mpv_property() {
  local property="$1"
  [[ -S "$SONICLI_SOCKET" ]] || return 1
  printf '{"command":["get_property","%s"]}\n' "$property" \
    | socat - "$SONICLI_SOCKET" 2>/dev/null \
    | jq -r '.data // empty' 2>/dev/null \
    | head -n 1
}

sonicli_stop_player() {
  if [[ -n "$SONICLI_MPV_PID" ]] && kill -0 "$SONICLI_MPV_PID" 2>/dev/null; then
    sonicli_mpv_send '{"command":["quit"]}' || true
    wait "$SONICLI_MPV_PID" 2>/dev/null || true
  fi
  rm -f "$SONICLI_SOCKET"
}

sonicli_draw_player_static() {
  local title="$1" artist="$2" cols maxtext
  cols=$(term_width)
  maxtext=$((cols - 4))
  (( maxtext < 20 )) && maxtext=20
  clear
  printf '%b\n' "${GREEN}${BOLD}SoniCLI${RESET} ${DARK}// TERMINAL AUDIO${RESET}"
  printf '%b\n' "${DARK}────────────────────────────────────────────────────────${RESET}"
  printf '%b\n' "${WHITE}${BOLD}$(truncate_text "$title" "$maxtext")${RESET}"
  printf '%b\n\n' "${PURPLE}$(truncate_text "$artist" "$maxtext")${RESET}"
  printf '%b\n' "${GRAY}STATUS${RESET}   ${GREEN2}● PLAYING${RESET}     ${GRAY}SOURCE${RESET} ${CYAN}NETWORK${RESET}"
  printf '\n'
  printf '%b\n' "${GRAY}SIGNAL${RESET}   "
  printf '\n'
  printf '%b\n' "${GRAY}PROGRESS${RESET} "
  printf '%b\n\n' "${GRAY}TIME${RESET}     "
  printf '%b\n' "${DARK}[Space] pause   [h/l] seek   [9/0] volume   [q] quit${RESET}"
}

sonicli_play() {
  local id="$1" title="$2" artist="$3"
  local paused pos dur vol key state cols bar_width signal_width
  rm -f "$SONICLI_SOCKET"

  mpv \
    --no-video \
    --input-ipc-server="$SONICLI_SOCKET" \
    --ytdl-format=bestaudio \
    --volume=100 \
    --no-terminal \
    "https://www.youtube.com/watch?v=${id}" \
    >/dev/null 2>&1 &
  SONICLI_MPV_PID=$!

  for _ in {1..30}; do
    [[ -S "$SONICLI_SOCKET" ]] && break
    sleep 0.1
  done
  [[ -S "$SONICLI_SOCKET" ]] || sonicli_die "mpv IPC socket did not start."

  sonicli_draw_player_static "$title" "$artist"
  trap sonicli_stop_player INT TERM EXIT

  while kill -0 "$SONICLI_MPV_PID" 2>/dev/null; do
    paused=$(sonicli_mpv_property pause || true)
    pos=$(sonicli_mpv_property time-pos || printf '0')
    dur=$(sonicli_mpv_property duration || printf '0')
    vol=$(sonicli_mpv_property volume || printf '100')
    [[ "$paused" == "true" ]] && state="${YELLOW}● PAUSED${RESET}" || state="${GREEN2}● PLAYING${RESET}"

    cols=$(term_width)
    bar_width=$((cols - 14)); (( bar_width > 42 )) && bar_width=42; (( bar_width < 16 )) && bar_width=16
    signal_width=$((cols - 14)); (( signal_width > 34 )) && signal_width=34; (( signal_width < 12 )) && signal_width=12

    printf '\033[6;1H\033[2K%b' "${GRAY}STATUS${RESET}   ${state}     ${GRAY}VOL${RESET} ${CYAN}${vol%.*}%${RESET}"
    printf '\033[8;1H\033[2K%b' "${GRAY}SIGNAL${RESET}   "
    sonicli_signal_line "$signal_width"
    printf '\033[10;1H\033[2K%b' "${GRAY}PROGRESS${RESET} "
    sonicli_progress_bar "$pos" "$dur" "$bar_width"
    printf '\033[11;1H\033[2K%b' "${GRAY}TIME${RESET}     ${WHITE}$(format_time "$pos")${RESET} ${DARK}/ ${RESET}${WHITE}$(format_time "$dur")${RESET}"

    if IFS= read -rsn1 -t 0.30 key; then
      case "$key" in
        ' ') sonicli_mpv_send '{"command":["cycle","pause"]}' ;;
        h|H) sonicli_mpv_send '{"command":["seek",-5,"relative"]}' ;;
        l|L) sonicli_mpv_send '{"command":["seek",5,"relative"]}' ;;
        9) sonicli_mpv_send '{"command":["add","volume",-5]}' ;;
        0) sonicli_mpv_send '{"command":["add","volume",5]}' ;;
        q|Q) sonicli_stop_player; break ;;
      esac
    fi
  done

  trap - INT TERM EXIT
  sonicli_stop_player
  printf '\033[14;1H'
}
