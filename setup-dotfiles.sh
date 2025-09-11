#!/bin/bash

# Simple setup script to install dotfiles using GNU Stow
# Useful when you only want the configurations

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Setting up dotfiles with GNU Stow...${NC}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if stow is available
if ! command -v stow >/dev/null 2>&1; then
    echo -e "${RED}✗ GNU Stow is not installed${NC}"
    echo -e "${BLUE}Please install stow first:${NC}"
    echo -e "  sudo apt install stow   # On Ubuntu/Debian"
    echo -e "  brew install stow       # On macOS"
    exit 1
fi

# Check if script directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    echo -e "${RED}✗ Script directory not found: $SCRIPT_DIR${NC}"
    exit 1
fi

# Change to script directory
cd "$SCRIPT_DIR" || {
    echo -e "${RED}✗ Could not change to script directory${NC}"
    exit 1
}

echo -e "${BLUE}Available packages:${NC}"
ls -1 */

echo

# Stow all packages
for package in */; do
    package_name=${package%/}
    # Skip non-package directories
    if [[ "$package_name" == ".git" ]]; then
        continue
    fi
    echo -e "${BLUE}📦 Stowing package: $package_name${NC}"
    
    # Remove trailing slash and stow the package
    if stow -v "$package_name" -t "$HOME" 2>&1; then
        echo -e "${GREEN}✓ Successfully stowed $package_name${NC}"
    else
        echo -e "${RED}✗ Failed to stow $package_name${NC}"
        echo -e "${BLUE}  (This may be due to existing files - use 'stow -D $package_name' to unstow first)${NC}"
    fi
    echo
done

echo -e "${GREEN}✓ Dotfiles setup complete!${NC}"
echo -e "${BLUE}To unstow a package, run: stow -D <package-name> -t \$HOME${NC}"
echo -e "${BLUE}To restow a package, run: stow -R <package-name> -t \$HOME${NC}"
echo -e "${BLUE}Remember to:${NC}"
echo -e "  1. Restart your shell or run: source ~/.bashrc"
echo -e "  2. Update git config with your name and email"
echo -e "  3. Install the utility tools with: ./install.sh"