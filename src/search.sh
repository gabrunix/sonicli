#!/usr/bin/env bash

sonicli_search() {
  local query="$1"
  yt-dlp "ytsearch30:${query}" \
    --flat-playlist \
    --no-warnings \
    --print '%(title)s\t%(channel)s\t%(duration_string)s\t%(id)s'
}

sonicli_choose_result() {
  local results="$1"
  printf '%s\n' "$results" | fzf \
    --delimiter=$'\t' \
    --with-nth=1,2,3 \
    --height=80% \
    --layout=reverse \
    --border=rounded \
    --prompt='♪  ' \
    --pointer='▶' \
    --marker='✓' \
    --header='Select an option: Enter = play • Esc = back' \
    --color='bg:#0d1117,bg+:#16222d,fg:#9be29b,fg+:#ffffff,hl:#00ff87,hl+:#00ffff,border:#00aa66,prompt:#00ff87,pointer:#ffcc00,marker:#ff55ff,header:#5fd7ff,info:#af87ff'
}
