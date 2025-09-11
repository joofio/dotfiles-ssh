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


# Load aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# Add ~/.local/bin to PATH if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path=("$HOME/.local/bin" $path)
fi

# Add ~/.cargo/bin to PATH if it exists (for Rust tools)
if [ -d "$HOME/.cargo/bin" ] ; then
    path=("$HOME/.cargo/bin" $path)
fi

# Add /opt/nvim-linux-x86_64/bin to PATH if it exists (for Neovim)
if [ -d "/opt/nvim-linux-x86_64/bin" ] ; then
    path=("/opt/nvim-linux-x86_64/bin" $path)
fi

# Initialize zoxide if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Initialize starship prompt if available
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi



# Source fzf configuration if available
if command -v fzf >/dev/null 2>&1; then
    # Source fzf zsh completion and key bindings
    if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
        source /usr/share/doc/fzf/examples/completion.zsh
    fi
    if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
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

# Initialize atuin if available
    eval "$(atuin init zsh)"
