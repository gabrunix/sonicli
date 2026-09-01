# SoniCLI

**A lightweight terminal music player for Linux and Termux.**

Search. Stream. Listen. Without leaving your terminal.

SoniCLI combines `yt-dlp`, `fzf`, and `mpv` behind a fast interactive CLI/TUI designed for Unix-like environments.

## Features

- Search music from the terminal.
- Interactive `fzf` result selection.
- Audio playback powered by `mpv`.
- Low-flicker terminal playback screen.
- Pause, seek, and volume controls.
- Direct search from the command line.
- Installer that detects Termux, APT, pacman, or dnf environments.
- Initial packaging templates for Debian and Termux.

## Supported environments

- Termux on Android
- Debian
- Ubuntu
- Kali Linux
- Linux Mint
- Pop!_OS
- Arch Linux
- Manjaro
- Fedora

Other Unix-like systems may work when the required dependencies are installed manually.

## Quick start

```bash
git clone https://github.com/gabrunix/sonicli.git
cd sonicli
./install.sh
sonicli
```

Direct search:

```bash
sonicli "Linkin Park Numb"
```

## Usage

```text
sonicli                  Start interactive mode
sonicli <search terms>   Search immediately
sonicli --help           Show help
sonicli --version        Show version
```

### Player controls

```text
Space   Pause / resume
h       Seek backward 5 seconds
l       Seek forward 5 seconds
9       Volume -5
0       Volume +5
q       Quit playback
```

## Dependencies

Core dependencies:

- Bash
- yt-dlp
- mpv
- fzf
- jq
- socat
- figlet
- Python

`./install.sh` installs the supported system dependencies automatically where possible.

## Project structure

```text
sonicli/
├── bin/
│   └── sonicli
├── src/
│   ├── colors.sh
│   ├── player.sh
│   ├── search.sh
│   ├── ui.sh
│   └── utils.sh
├── packaging/
│   ├── debian/
│   └── termux/
├── install.sh
├── uninstall.sh
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
├── README.md
└── VERSION
```

## Packaging roadmap

The initial installer provides a universal installation path. Package-manager distribution is planned in stages:

1. GitHub Releases.
2. Debian `.deb` package.
3. Termux package recipe.
4. Optional APT repository.
5. Submission to community/official repositories where appropriate.

## Development

Run from the repository without installing:

```bash
./bin/sonicli
```

Syntax check:

```bash
bash -n bin/sonicli src/*.sh install.sh uninstall.sh
```

## License

SoniCLI is released under the MIT License. See [LICENSE](LICENSE).

## Disclaimer

SoniCLI is a terminal frontend around third-party tools and services. Users are responsible for complying with applicable platform terms, copyright rules, and local laws.
