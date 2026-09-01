#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *com.termux* ]]; then
  rm -f "$PREFIX/bin/sonicli"
  rm -rf "$PREFIX/lib/sonicli" "$PREFIX/share/sonicli"
else
  sudo rm -f /usr/local/bin/sonicli
  sudo rm -rf /usr/local/lib/sonicli /usr/local/share/sonicli
fi
printf 'SoniCLI removed. Dependencies were left installed.\n'
