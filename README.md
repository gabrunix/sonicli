# 🎵 SoniCLI

![Version](https://img.shields.io/badge/version-0.1.0-00ff87)
![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Termux-yellow)
![Shell](https://img.shields.io/badge/shell-Bash-lightgrey)

**A lightweight terminal music player for Linux and Termux.**

> Search. Stream. Listen. Without leaving your terminal.

SoniCLI brings music search and playback directly to the command line using a lightweight, keyboard-driven interface.

---

## ✨ Features

- 🔎 Search for music from the terminal
- 🎵 Stream online audio
- ▶️ Playback powered by `mpv`
- ⚡ Media extraction with `yt-dlp`
- 🔍 Interactive selection with `fzf`
- ⌨️ Keyboard playback controls
- 📊 Lightweight terminal visualization
- 🐧 Linux support
- 📱 Termux support
- 🔓 Open source

---

## 🚀 Quick Install

### Termux

```bash
pkg update
pkg install git -y

git clone https://github.com/gabrunix/sonicli.git
cd sonicli
chmod +x install.sh
./install.sh
```

### Linux

```bash
git clone https://github.com/gabrunix/sonicli.git
cd sonicli
chmod +x install.sh
./install.sh
```

Once installed:

```bash
sonicli
```

---

## 🎧 Usage

Launch the interactive player:

```bash
sonicli
```

Search directly:

```bash
sonicli "Linkin Park Numb"
```

Show help:

```bash
sonicli --help
```

Show version:

```bash
sonicli --version
```

---

## ⌨️ Controls

```text
SPACE    Play / Pause
h        Seek backward
l        Seek forward
9        Volume down
0        Volume up
q        Quit
```

---

## 📦 Requirements

SoniCLI uses:

- `yt-dlp`
- `mpv`
- `fzf`
- `jq`
- `socat`
- `FIGlet`

The installer handles supported dependencies automatically.

See [`THIRD_PARTY_LICENSES.md`](THIRD_PARTY_LICENSES.md) for third-party licensing information.

---

## 🐧 Platforms

SoniCLI is designed for Unix-like environments.

Currently targeted:

- Termux / Android
- Debian / Ubuntu
- Kali Linux
- Linux Mint
- Pop!_OS
- Arch Linux / Manjaro
- Fedora

> Platform support depends on the availability of the required packages.

---

## 🗺️ Roadmap

- [x] Music search
- [x] Interactive result selection
- [x] mpv playback
- [x] Keyboard controls
- [x] Linux & Termux foundation
- [ ] Favorites
- [ ] Search history
- [ ] Themes
- [ ] Improved visualizer
- [ ] Android media controls
- [ ] Debian package
- [ ] Termux package
- [ ] Automated releases
- [ ] SoniCLI v1.0

---

## 🤝 Contributing

Contributions, bug reports and feature suggestions are welcome.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for development and contribution guidelines.

---

## ⚖️ Disclaimer

SoniCLI is an independent open-source terminal music player.

SoniCLI does not host, distribute, or store media content. It uses external tools such as `yt-dlp` and `mpv` to access media requested by the user.

Users are responsible for complying with the terms of service of the platforms they access and with applicable copyright laws.

SoniCLI is not affiliated with YouTube, Google, yt-dlp, mpv, or any supported media platform.

---

## 📜 License

SoniCLI is released under the **MIT License**.

See [`LICENSE`](LICENSE) for details.

---

<p align="center">
  <strong>SoniCLI</strong><br>
  Search • Stream • Listen • Terminal
</p>
