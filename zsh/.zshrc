cat /home/vinzz/Documents/Ricing/VinzzASCII.txt

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

#plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

#Load completions
autoload -U compinit && compinit

#Keybindings for autocompletions and settings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-serach-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space #se metti uno spazio davanti al comando non verrà salvato nella history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups 



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------------------------------
# FLUTTER + ANDROID + JAVA CONFIG
# -------------------------------

# Flutter SDK
export FLUTTER_HOME=/usr/share/flutter
export PATH=$FLUTTER_HOME/bin:$PATH

# Android SDK
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Java JDK (OpenJDK 21)
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH


#---------------------------------
#         PATH RELATIVO
#---------------------------------
export PATH="$PATH:$HOME:." #aggiunge la home e la cartella corrente al path di ricerca

#---------------------------------
#Variabile d'ambiente per tmuxifier
#---------------------------------
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

#---------------------------------
#             ALIASES
#---------------------------------
alias dots='cd ~/dotfiles'
alias dotsync='cd ~/dotfiles && git add . && git commit -m "update dotfiles" && git push'
alias dotpull='cd ~/dotfiles && git pull && stow -R .'
alias algs='cd ~/Documents/Algorythms/'
alias algssync='cd ~/Documents/Algorythms/ && git add . && git commit -m "update Algorythms" && git push '

alias ff='fastfetch'
alias uni='cd ~/Documents/Uni/'
alias lg='lazygit'
alias fpg='flutter clean & flutter pub get'

#Fast Node Manager (needed for npm - node package manager)
eval "$(fnm env --use-on-cd)"

export EDITOR="nvim"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
