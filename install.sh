#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
IS_TERMUX=0
[[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *com.termux* ]] && IS_TERMUX=1

say() { printf '\033[38;2;0;255;135m[SoniCLI]\033[0m %s\n' "$*"; }
warn() { printf '\033[38;2;255;230;0m[warning]\033[0m %s\n' "$*" >&2; }

install_packages() {
  if (( IS_TERMUX )); then
    say "Detected Termux"
    pkg update -y
    pkg install -y mpv fzf jq socat figlet python
  elif command -v apt-get >/dev/null 2>&1; then
    say "Detected APT-based Linux"
    sudo apt-get update
    sudo apt-get install -y mpv fzf jq socat figlet python3 python3-pip
  elif command -v pacman >/dev/null 2>&1; then
    say "Detected pacman-based Linux"
    sudo pacman -S --needed --noconfirm mpv fzf jq socat figlet python python-pip
  elif command -v dnf >/dev/null 2>&1; then
    say "Detected Fedora/RHEL family"
    sudo dnf install -y mpv fzf jq socat figlet python3 python3-pip
  else
    warn "Unsupported package manager. Install mpv, fzf, jq, socat, figlet, Python and yt-dlp manually."
  fi
}

install_ytdlp() {
  if command -v yt-dlp >/dev/null 2>&1; then
    return
  fi
  say "Installing yt-dlp"
  if (( IS_TERMUX )); then
    python -m pip install -U yt-dlp
  elif command -v pipx >/dev/null 2>&1; then
    pipx install yt-dlp
  else
    python3 -m pip install --user -U yt-dlp || {
      warn "pip user install failed. Try your distro's yt-dlp package or pipx."
      return 1
    }
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

install_sonicli() {
  local bindir libdir sharedir
  if (( IS_TERMUX )); then
    bindir="$PREFIX/bin"
    libdir="$PREFIX/lib/sonicli"
    sharedir="$PREFIX/share/sonicli"
    mkdir -p "$libdir" "$sharedir"
    cp "$ROOT_DIR/bin/sonicli" "$bindir/sonicli"
    cp "$ROOT_DIR"/src/*.sh "$libdir/"
    cp "$ROOT_DIR/VERSION" "$sharedir/VERSION"
    chmod +x "$bindir/sonicli"
  else
    bindir="/usr/local/bin"
    libdir="/usr/local/lib/sonicli"
    sharedir="/usr/local/share/sonicli"
    sudo mkdir -p "$libdir" "$sharedir"
    sudo cp "$ROOT_DIR/bin/sonicli" "$bindir/sonicli"
    sudo cp "$ROOT_DIR"/src/*.sh "$libdir/"
    sudo cp "$ROOT_DIR/VERSION" "$sharedir/VERSION"
    sudo chmod +x "$bindir/sonicli"
  fi
}

install_packages
install_ytdlp
install_sonicli
say "Installation complete. Run: sonicli"
