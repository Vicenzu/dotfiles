# 🧠 Vinzz's Arch Linux Dotfiles

Personal configuration files for my Arch Linux setup — minimal, modular, and managed with **GNU Stow**.

## 📦 Overview

These dotfiles include configuration for my daily setup:

- 🧭 **Zsh + Oh-My-Zsh + Powerlevel10k**
- 💻 **Neovim 0.11+** (Lua config, lazy.nvim — LSP, completion, DAP, LaTeX/vimtex, Markdown→PDF)
- 📁 **Yazi** file manager (Catppuccin flavor)
- </> **Kitty** / **Ghostty** terminals + **Tmux**
- 🧊  **Wofi**, **Waybar**, **Hyprlock/Hyprpaper**
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

### Pandoc (Markdown → PDF)
Install packages listed under [Dependencies → LaTeX](#latex-vimtex--texlab--markdownpdf). Standard Pandoc use:

```bash
pandoc <inputFile> -o <outputFile>.<desiredFileType>
```
Inside Neovim, `<leader>cl` (`:MakePDF`) converts the current Markdown file via `pandoc` + `xelatex`.

## 📥 Dependencies

### Core system packages (pacman)
```bash
sudo pacman -S neovim yazi git lazygit ripgrep fd fzf zoxide \
    nodejs npm python python-pip jdk-openjdk unzip wget curl
```
- `ripgrep` (`rg`) + `fd` — snacks/telescope pickers **and** yazi search (`s`/`S`).
- `fzf` + `zoxide` — yazi jump keymaps (`z` / `Z`). **`zoxide` is required or the `Z` keymap fails.**
- `nodejs`/`npm` — needed by Mason JS-based servers (ts_ls, angularls/ngserver, emmet, prettier, biome).
- `python`/`pip` — for `black` + `isort` (Python formatters). `jdk-openjdk` — for `google-java-format` / `checkstyle`.

### A Nerd Font
Icons in Neovim, Yazi and the statusline need a patched font, e.g.:
```bash
sudo pacman -S ttf-jetbrains-mono-nerd   # or any *-nerd font
```

### Neovim — Mason-managed tools
LSP servers auto-install on first launch (`ensure_installed`). Formatters/linters install on demand — run once:
```
:MasonInstall stylua prettier biome black isort google-java-format \
    rubocop checkstyle phpcs
```
LSP servers pulled by Mason: `lua_ls`, `typescript-language-server`, `denols`, `basedpyright`,
`clangd`, `omnisharp`, `intelephense`, `emmet-language-server`, `sql-language-server`, `asm-lsp`,
`marksman`, `lemminx`, `ltex-ls-plus`, `ngserver` (Angular). `texlab` (LaTeX) is a **system**
binary — `sudo pacman -S texlab`.

### Java linting — checkstyle config
`nvim-lint` (checkstyle) needs Google's ruleset at a fixed path:
```bash
mkdir -p ~/.local/share/nvim/checkstyle
curl -fsSL https://raw.githubusercontent.com/checkstyle/checkstyle/master/src/main/resources/google_checks.xml \
    -o ~/.local/share/nvim/checkstyle/google_checks.xml
```

### LaTeX (vimtex + texlab + Markdown→PDF)
```bash
sudo pacman -S texlab zathura zathura-pdf-mupdf \
    texlive-binextra texlive-latexindent-meta pandoc \
    texlive-core texlive-latexextra texlive-langitalian \
    texlive-latexrecommended texlive-fontsrecommended texlive-xetex
```
- `latexmk` (build) + `zathura` (SyncTeX viewer) + `latexindent` (formatter) + `chktex` (lint) —
  all from TeXLive. `pandoc` + `xelatex` power the `:MakePDF` Markdown→PDF command (`<leader>cl`).

### Yazi — preview helpers (optional but recommended)
```bash
sudo pacman -S ffmpeg 7zip jq poppler fontpreview imagemagick
```

## 🧠 Notes

- The system language is English (en_US.UTF-8), but the time/date format uses Italian locale (it_IT.UTF-8).
- All cache, credentials, and history files are excluded via .gitignore.
- Tested on Arch Linux (KDE Plasma 6).

> Author: Vinzz
