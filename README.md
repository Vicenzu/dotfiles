# 🧠 Vinzz's Arch Linux Dotfiles

Personal configuration files for my Arch Linux setup — minimal, modular, and managed with **GNU Stow**.

## 📦 Overview

These dotfiles include configuration for my daily setup:

- 🧭 **Zsh + Oh-My-Zsh + Powerlevel10k**
- 💻 **Neovim 0.11+** (LSP, Lua config)
- </> **Kitty** terminal
- 🧊  **Wofi**
- ⚙️ **Fastfetch**, **Btop**, **Lazygit**
- 🧰 Custom scripts for system maintenance and battery management
- 🌐 Locale configuration (system in English, time/date in Italian)

---

## 🗂️ Structure

~/.dotfiles/

├── backgrounds/ -> wallpapers

├── zsh/ → .zshrc, .p10k.zsh, .shell.pre-oh-my-zsh

├── git/ → .gitconfig

├── nvim/

├── kitty/

├── fastfetch/

├── wofi/ -> 3 different configs (wofi2 default config) 

├── btop/

├── lazygit/

├── ghostty/

├── hyprlock/

├── hyprmocha/

├── hyprpaper/

├── waybar/

├── tmux/

├── yazi/

├── scripts/ → custom shell scripts

│ ├── chargeLimit.sh

│ └── cleaning.sh

└── locale/ → reference copy of /etc/locale.conf


---

## ⚙️ Usage 

### GNU Stow
Clone the repo into your home directory:
```bash
git clone https://github.com/vinzz/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## 🧹 Unstow (remove symlinks)
```bash
stow -D zsh
stow -D -t ~/.config .config
```

### Pandoc & TexLive
Install packages

```bash
sudo pacman -S pandoc texlive-core texlive-latexextra texlive-langitalian
    texlive-latexrecommended texlive-fontsrecommended texlive-xetex
```

texlive-xetex (optional) – newer pdf-engine

Standard Pandoc use:

```bash
pandoc <inputFile> -o <outputFile>.<desiredFileType>
```

## 🧠 Notes

- The system language is English (en_US.UTF-8), but the time/date format uses Italian locale (it_IT.UTF-8).
- All cache, credentials, and history files are excluded via .gitignore.
- Tested on Arch Linux (KDE Plasma 6).

> Author: Vinzz
