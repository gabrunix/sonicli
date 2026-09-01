TERMUX_PKG_HOMEPAGE=https://github.com/gabrunix/sonicli
TERMUX_PKG_DESCRIPTION="Lightweight terminal music player"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=0.1.0
TERMUX_PKG_SRCURL=https://github.com/gabrunix/sonicli/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=SKIP
TERMUX_PKG_DEPENDS="bash, mpv, fzf, jq, socat, figlet, python"
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install() {
  install -Dm755 "$TERMUX_PKG_SRCDIR/bin/sonicli" "$TERMUX_PREFIX/bin/sonicli"
  for f in "$TERMUX_PKG_SRCDIR"/src/*.sh; do
    install -Dm644 "$f" "$TERMUX_PREFIX/lib/sonicli/$(basename "$f")"
  done
  install -Dm644 "$TERMUX_PKG_SRCDIR/VERSION" "$TERMUX_PREFIX/share/sonicli/VERSION"
}
