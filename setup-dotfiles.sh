#!/bin/bash

# Simple setup script to copy dotfiles without installing tools
# Useful when you only want the configurations

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Setting up dotfiles...${NC}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Backup existing files
backup_file() {
    if [ -f "$1" ]; then
        cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${BLUE}Backed up existing $1${NC}"
    fi
}

# Copy dotfiles
copy_dotfile() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$src" ]; then
        backup_file "$dest"
        cp "$src" "$dest"
        echo -e "${GREEN}✓ Installed $dest${NC}"
    else
        echo -e "${BLUE}⚠ $src not found, skipping${NC}"
    fi
}

# Copy configurations
copy_dotfile "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
copy_dotfile "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
copy_dotfile "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
copy_dotfile "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
copy_dotfile "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/atuin"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/lazydocker"
copy_dotfile "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
copy_dotfile "$DOTFILES_DIR/fzf-config.sh" "$HOME/.config/fzf-config.sh"
copy_dotfile "$DOTFILES_DIR/atuin-config.toml" "$HOME/.config/atuin/config.toml"
copy_dotfile "$DOTFILES_DIR/lazygit-config.yml" "$HOME/.config/lazygit/config.yml"
copy_dotfile "$DOTFILES_DIR/lazydocker-config.yml" "$HOME/.config/lazydocker/config.yml"

echo -e "${GREEN}✓ Dotfiles setup complete!${NC}"
echo -e "${BLUE}Remember to:${NC}"
echo -e "  1. Restart your shell or run: source ~/.bashrc"
echo -e "  2. Update git config with your name and email"
echo -e "  3. Install the utility tools with: ./install.sh"