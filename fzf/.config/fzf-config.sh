# FZF Configuration
# Set default command to use fd for faster search
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Set default options
export FZF_DEFAULT_OPTS="
--height 50%
--layout=reverse
--border
--info=inline
--prompt='❯ '
--pointer='▶'
--marker='✓'
--bind='?:toggle-preview'
--bind='ctrl-a:select-all'
--bind='ctrl-d:deselect-all'
--bind='ctrl-t:toggle-all'
--color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
--color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
--color=info:#83a598,prompt:#bdae93,pointer:#84a0c6
--color=marker:#fe8019,spinner:#fabd2f,header:#665c54"

# Use fd for path completion
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview 'bat --color=always --line-range :50 {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Use fd for directory search
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="
--preview 'tree -C {} | head -50'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Use fd for completion
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -50' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview 'bat --color=always --line-range :50 {}' "$@" ;;
  esac
}