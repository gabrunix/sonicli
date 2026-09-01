#!/usr/bin/env bash

SONICLI_SIGNAL_CHARS=('▁' '▂' '▃' '▄' '▅' '▆' '▇' '█')
SONICLI_SIGNAL_COLORS=("$GREEN" "$GREEN2" "$CYAN" "$BLUE" "$PURPLE" "$MAGENTA")

sonicli_logo() {
  clear
  if command_exists figlet; then
    printf '%b' "$GREEN$BOLD"
    figlet -f small "SoniCLI" 2>/dev/null || printf 'SoniCLI\n'
    printf '%b' "$RESET"
  else
    printf '%b\n' "${GREEN}${BOLD}SoniCLI${RESET}"
  fi
  printf '%b\n' "${CYAN}TERMINAL MUSIC PLAYER${RESET}  ${GRAY}// Linux • Unix • Termux${RESET}"
  printf '%b\n\n' "${DARK}Search. Stream. Listen. Without leaving your terminal.${RESET}"
}

sonicli_signal_line() {
  local width=${1:-28} i level color
  for ((i=0; i<width; i++)); do
    level=$((RANDOM % ${#SONICLI_SIGNAL_CHARS[@]}))
    color=${SONICLI_SIGNAL_COLORS[$((i % ${#SONICLI_SIGNAL_COLORS[@]}))]}
    printf '%b%s' "$color" "${SONICLI_SIGNAL_CHARS[$level]}"
  done
  printf '%b' "$RESET"
}

sonicli_progress_bar() {
  local pos=${1:-0} dur=${2:-0} width=${3:-30}
  local filled=0 i
  [[ "$pos" =~ ^[0-9]+([.][0-9]+)?$ ]] || pos=0
  [[ "$dur" =~ ^[0-9]+([.][0-9]+)?$ ]] || dur=0
  if awk "BEGIN{exit !($dur > 0)}"; then
    filled=$(awk -v p="$pos" -v d="$dur" -v w="$width" 'BEGIN{f=int((p/d)*w); if(f<0)f=0; if(f>w)f=w; print f}')
  fi
  for ((i=0; i<width; i++)); do
    if (( i < filled )); then
      printf '%b━' "$GREEN2"
    elif (( i == filled && filled < width )); then
      printf '%b●' "$YELLOW"
    else
      printf '%b─' "$DARK"
    fi
  done
  printf '%b' "$RESET"
}
