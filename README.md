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

├── zsh/ → .zshrc, .p10k.zsh, .shell.pre-oh-my-zsh

├── git/ → .gitconfig

├── config/ → user-level configs under .config/

│ └── .config/

│ ├── nvim/

│ ├── kitty/

│ ├── fastfetch/

│ ├── wofi/

│ ├── btop/

│ └── lazygit/

├── scripts/ → custom shell scripts

│ ├── chargeLimit.sh

│ └── cleaning.sh

└── locale/ → reference copy of /etc/locale.conf


---

## ⚙️ Usage (with GNU Stow)

Clone the repo into your home directory:
```bash
git clone https://github.com/vinzz/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## ⚠️ IMPORTANT -- .config folder

Do **not** run `stow .config` directly! (It will create the links in your home directory instead of ~/.config.)

Run `stow -t ~/.config .config` instead

### If you ever move things around, use:
`stow -R -t ~/.config .config`

to restow and refresh all the symlinks safely.

## 🧹 Unstow (remove symlinks)
```bash
stow -D zsh
stow -D -t ~/.config .config
```

## 🧠 Notes

- The system language is English (en_US.UTF-8), but the time/date format uses Italian locale (it_IT.UTF-8).
- All cache, credentials, and history files are excluded via .gitignore.
- Tested on Arch Linux (KDE Plasma 6).

> Author: Vinzz
