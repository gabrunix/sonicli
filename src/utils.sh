#!/usr/bin/env bash

sonicli_die() {
  printf '%b\n' "${RED:-}error:${RESET:-} $*" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

term_width() {
  local cols
  cols=$(tput cols 2>/dev/null || printf '80')
  [[ "$cols" =~ ^[0-9]+$ ]] || cols=80
  printf '%s' "$cols"
}

truncate_text() {
  local text="$1" max="$2"
  if (( ${#text} <= max )); then
    printf '%s' "$text"
  elif (( max > 1 )); then
    printf '%s…' "${text:0:max-1}"
  else
    printf '%s' "${text:0:max}"
  fi
}

format_time() {
  local value=${1:-0}
  [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] || value=0
  value=${value%.*}
  printf '%02d:%02d' $((value / 60)) $((value % 60))
}
