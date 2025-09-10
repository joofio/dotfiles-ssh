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
    alias l='eza -la --color=auto --icons'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias ccat='command cat'  # Original cat command
    alias less='bat --paging=always'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
    alias rgrep='rg'
fi

if command -v btop >/dev/null 2>&1; then
    alias top='btop'
    alias htop='btop'
fi

if command -v dust >/dev/null 2>&1; then
    alias du='dust'
    alias ddu='command du'  # Original du command
fi

if command -v procs >/dev/null 2>&1; then
    alias ps='procs'
    alias pps='command ps'  # Original ps command
fi

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias cd..='cd ..'
alias ~='cd ~'

# File operations aliases
alias mkdir='mkdir -p'
alias md='mkdir -p'
alias rd='rmdir'
alias which='type -a'

# System aliases
alias h='history'
alias j='jobs -l'
alias ports='netstat -tulanp'
alias listening='netstat -tlnp'
alias ss='ss -tuln'
alias mount='mount | column -t'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Process management aliases
alias topcpu='ps auxf | sort -nr -k 3 | head -10'
alias topmem='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Network aliases
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# Disk usage aliases  
alias diskusage='df -h'
alias foldersize='du -sh'
alias largest='du -sh * | sort -hr | head -10'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gp='git push'
alias gpo='git push origin'
alias gl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'
alias glol='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gst='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gm='git merge'
alias gr='git remote'
alias grv='git remote -v'
alias gf='git fetch'
alias gt='git tag'
alias gclean='git clean -fd'
alias greset='git reset --hard HEAD'

# Docker aliases (if docker is available)
if command -v docker >/dev/null 2>&1; then
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs'
    alias dlogf='docker logs -f'
    alias dstop='docker stop'
    alias dstart='docker start'
    alias drm='docker rm'
    alias drmi='docker rmi'
    alias dprune='docker system prune -a'
    alias dstats='docker stats'
fi

# Docker Compose aliases (if docker-compose is available)
if command -v docker-compose >/dev/null 2>&1; then
    alias dcu='docker-compose up'
    alias dcd='docker-compose down'
    alias dcb='docker-compose build'
    alias dcl='docker-compose logs'
    alias dcr='docker-compose restart'
fi

# Lazydocker alias (if lazydocker is available)
if command -v lazydocker >/dev/null 2>&1; then
    alias lzd='lazydocker'
fi

# Lazygit alias (if lazygit is available)
if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
fi

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
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias cheat='curl cht.sh'
alias dict='curl dict://dict.org/d'

# Archive aliases
alias tarls='tar -tvf'
alias untar='tar -xf'
alias targz='tar -czf'
alias tarxz='tar -cJf'

# Text processing aliases
alias count='sort | uniq -c | sort -nr'
alias freq='cut -f1 -d" " | sort | uniq -c | sort -nr'

# Date and time aliases
alias timestamp='date +%s'
alias isodate='date --iso-8601'
alias utc='date -u'

# Memory and system info
alias meminfo='cat /proc/meminfo'
alias cpuinfo='cat /proc/cpuinfo'
alias distro='cat /etc/*-release'

# Useful shortcuts
alias c='clear'
alias e='exit'
alias q='exit'
alias x='exit'
alias reload='source ~/.bashrc'
alias path='echo $PATH | tr ":" "\n"'

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

# Source fzf configuration if available
if command -v fzf >/dev/null 2>&1; then
    # Source fzf bash completion and key bindings
    if [ -f /usr/share/bash-completion/completions/fzf ]; then
        source /usr/share/bash-completion/completions/fzf
    fi
    if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
        source /usr/share/doc/fzf/examples/key-bindings.bash
    fi
    # Source custom fzf configuration
    if [ -f ~/.config/fzf-config.sh ]; then
        source ~/.config/fzf-config.sh
    fi
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