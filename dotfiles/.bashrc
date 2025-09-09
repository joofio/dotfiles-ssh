# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add ~/.local/bin to PATH if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add ~/.cargo/bin to PATH if it exists (for Rust tools)
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Initialize zoxide if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# Initialize starship prompt if available
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Initialize atuin if available
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash)"
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