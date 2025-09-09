# ~/.zshrc: executed by zsh for interactive shells

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Enable auto-completion
autoload -Uz compinit
compinit

# Make completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Enable auto-correction
setopt CORRECT

# Enable colors
autoload -U colors && colors

# Some useful aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Modern tool aliases
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --color=auto'
    alias ll='eza -la --color=auto --icons'
    alias la='eza -la --color=auto --icons'
    alias lt='eza --tree --color=auto --icons'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias ccat='command cat'  # Original cat command
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
fi

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System aliases
alias h='history'
alias j='jobs -l'
alias ports='netstat -tulanp'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias glog='git log --oneline --graph --decorate'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utility aliases
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias psg='ps aux | grep'
alias myip='curl -s ifconfig.me'
alias weather='curl -s wttr.in'

# Add ~/.local/bin to PATH if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path=("$HOME/.local/bin" $path)
fi

# Add ~/.cargo/bin to PATH if it exists (for Rust tools)
if [ -d "$HOME/.cargo/bin" ] ; then
    path=("$HOME/.cargo/bin" $path)
fi

# Initialize zoxide if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Initialize starship prompt if available
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Initialize atuin if available
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

# Custom functions
# Extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find and kill process by name
killp() {
    ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# Create backup of file
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}