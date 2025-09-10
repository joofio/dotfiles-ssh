#!/bin/bash

# Dotfiles installation script for Ubuntu servers
# Installs common utility tools and sets up dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Ubuntu
check_ubuntu() {
    if ! grep -q "ubuntu" /etc/os-release; then
        log_error "This script is designed for Ubuntu systems"
        exit 1
    fi
    log_info "Ubuntu system detected"
}

# Update system packages
update_system() {
    log_info "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    log_success "System packages updated"
}

# Install basic dependencies
install_dependencies() {
    log_info "Installing basic dependencies..."
    sudo apt install -y curl wget git unzip software-properties-common apt-transport-https ca-certificates gnupg lsb-release
    log_success "Basic dependencies installed"
}

# Install bat (better cat)
install_bat() {
    log_info "Installing bat..."
    if command -v bat >/dev/null 2>&1; then
        log_warning "bat is already installed"
        return
    fi
    
    # Use apt if available in newer Ubuntu versions
    if apt list bat 2>/dev/null | grep -q bat; then
        sudo apt install -y bat
    else
        # Download from GitHub releases for older Ubuntu versions
        BAT_VERSION=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep -Po '"tag_name": "\K[^"]*')
        wget -O /tmp/bat.deb "https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat_${BAT_VERSION#v}_amd64.deb"
        sudo dpkg -i /tmp/bat.deb || sudo apt install -f -y
        rm /tmp/bat.deb
    fi
    log_success "bat installed"
}

# Install eza (modern ls)
install_eza() {
    log_info "Installing eza..."
    if command -v eza >/dev/null 2>&1; then
        log_warning "eza is already installed"
        return
    fi
    
    # Add GPG key and repository
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update && sudo apt install -y eza
    log_success "eza installed"
}

# Install fd (better find)
install_fd() {
    log_info "Installing fd..."
    if command -v fd >/dev/null 2>&1; then
        log_warning "fd is already installed"
        return
    fi
    
    sudo apt install -y fd-find
    # Create symlink for fd command
    if [ ! -f ~/.local/bin/fd ]; then
        mkdir -p ~/.local/bin
        ln -sf /usr/bin/fdfind ~/.local/bin/fd
    fi
    log_success "fd installed"
}

# Install ripgrep (better grep)
install_ripgrep() {
    log_info "Installing ripgrep..."
    if command -v rg >/dev/null 2>&1; then
        log_warning "ripgrep is already installed"
        return
    fi
    
    sudo apt install -y ripgrep
    log_success "ripgrep installed"
}

# Install zoxide (better cd)
install_zoxide() {
    log_info "Installing zoxide..."
    if command -v zoxide >/dev/null 2>&1; then
        log_warning "zoxide is already installed"
        return
    fi
    
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    log_success "zoxide installed"
}

# Install starship (cross-shell prompt)
install_starship() {
    log_info "Installing starship..."
    if command -v starship >/dev/null 2>&1; then
        log_warning "starship is already installed"
        return
    fi
    
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    log_success "starship installed"
}

# Install atuin (shell history)
install_atuin() {
    log_info "Installing atuin..."
    if command -v atuin >/dev/null 2>&1; then
        log_warning "atuin is already installed"
        return
    fi
    
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    log_success "atuin installed"
}

# Install tmux
install_tmux() {
    log_info "Installing tmux..."
    if command -v tmux >/dev/null 2>&1; then
        log_warning "tmux is already installed"
        return
    fi
    
    sudo apt install -y tmux
    log_success "tmux installed"
}

# Install btop (modern system monitor)
install_btop() {
    log_info "Installing btop..."
    if command -v btop >/dev/null 2>&1; then
        log_warning "btop is already installed"
        return
    fi
    
    # btop is available in Ubuntu 22.04+ repositories
    if apt list btop 2>/dev/null | grep -q btop; then
        sudo apt install -y btop
    else
        # Download from GitHub releases for older Ubuntu versions
        BTOP_VERSION=$(curl -s https://api.github.com/repos/aristocratos/btop/releases/latest | grep -Po '"tag_name": "\K[^"]*')
        wget -O /tmp/btop.tbz "https://github.com/aristocratos/btop/releases/download/${BTOP_VERSION}/btop-x86_64-linux-musl.tbz"
        tar -xjf /tmp/btop.tbz -C /tmp
        sudo cp /tmp/btop/bin/btop /usr/local/bin/
        rm -rf /tmp/btop /tmp/btop.tbz
    fi
    log_success "btop installed"
}

# Install dust (modern du)
install_dust() {
    log_info "Installing dust..."
    if command -v dust >/dev/null 2>&1; then
        log_warning "dust is already installed"
        return
    fi
    
    DUST_VERSION=$(curl -s https://api.github.com/repos/bootandy/dust/releases/latest | grep -Po '"tag_name": "\K[^"]*')
    wget -O /tmp/dust.tar.gz "https://github.com/bootandy/dust/releases/download/${DUST_VERSION}/dust-${DUST_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf /tmp/dust.tar.gz -C /tmp
    sudo cp "/tmp/dust-${DUST_VERSION}-x86_64-unknown-linux-musl/dust" /usr/local/bin/
    rm -rf /tmp/dust* 
    log_success "dust installed"
}

# Install procs (modern ps)
install_procs() {
    log_info "Installing procs..."
    if command -v procs >/dev/null 2>&1; then
        log_warning "procs is already installed"
        return
    fi
    
    PROCS_VERSION=$(curl -s https://api.github.com/repos/dalance/procs/releases/latest | grep -Po '"tag_name": "\K[^"]*')
    wget -O /tmp/procs.zip "https://github.com/dalance/procs/releases/download/${PROCS_VERSION}/procs-${PROCS_VERSION}-x86_64-linux.zip"
    unzip -q /tmp/procs.zip -d /tmp
    sudo cp /tmp/procs /usr/local/bin/
    rm -rf /tmp/procs*
    log_success "procs installed"
}

# Install delta (better git diff)
install_delta() {
    log_info "Installing delta..."
    if command -v delta >/dev/null 2>&1; then
        log_warning "delta is already installed"
        return
    fi
    
    DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep -Po '"tag_name": "\K[^"]*')
    wget -O /tmp/delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i /tmp/delta.deb || sudo apt install -f -y
    rm /tmp/delta.deb
    log_success "delta installed"
}

# Install fzf (fuzzy finder)
install_fzf() {
    log_info "Installing fzf..."
    if command -v fzf >/dev/null 2>&1; then
        log_warning "fzf is already installed"
        return
    fi
    
    sudo apt install -y fzf
    log_success "fzf installed"
}

# Install lazygit (git TUI)
install_lazygit() {
    log_info "Installing lazygit..."
    if command -v lazygit >/dev/null 2>&1; then
        log_warning "lazygit is already installed"
        return
    fi
    
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
    log_success "lazygit installed"
}

# Install lazydocker (docker TUI)
install_lazydocker() {
    log_info "Installing lazydocker..."
    if command -v lazydocker >/dev/null 2>&1; then
        log_warning "lazydocker is already installed"
        return
    fi
    
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    log_success "lazydocker installed"
}

# Install additional useful tools
install_additional_tools() {
    log_info "Installing additional useful tools..."
    sudo apt install -y \
        tree \
        jq \
        ncdu \
        tldr \
        neofetch \
        nvim \
        curl \
        wget \
        zip \
        unzip \
        p7zip-full \
        net-tools \
        dnsutils \
        traceroute \
        iotop \
        lsof \
        strace \
        tcpdump \
        stow
    log_success "Additional tools installed"
}

# Setup dotfiles
setup_dotfiles() {
    log_info "Setting up dotfiles using stow..."
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
    
    # Check if stow is available
    if ! command -v stow >/dev/null 2>&1; then
        log_error "GNU Stow is not installed. Please install it first."
        exit 1
    fi
    
    # Change to dotfiles directory
    cd "$DOTFILES_DIR" || {
        log_error "Could not change to dotfiles directory: $DOTFILES_DIR"
        exit 1
    }
    
    # Stow all packages
    for package in */; do
        package_name=${package%/}
        log_info "Stowing package: $package_name"
        
        # Remove trailing slash and stow the package
        if stow -v "$package_name" -t "$HOME"; then
            log_success "Successfully stowed $package_name"
        else
            log_warning "Failed to stow $package_name (conflicts may exist)"
        fi
    done
    
    log_success "Dotfiles setup with stow completed"
}

# Main installation function
main() {
    log_info "Starting dotfiles and utility tools installation..."
    
    check_ubuntu
    update_system
    install_dependencies
    
    install_bat
    install_eza
    install_fd
    install_ripgrep
    install_zoxide
    install_starship
    install_atuin
    install_tmux
    install_btop
    install_dust
    install_procs
    install_delta
    install_fzf
    install_lazygit
    install_lazydocker
    install_additional_tools
    
    setup_dotfiles
    
    log_success "Installation completed successfully!"
    log_info "Please restart your shell or run 'source ~/.bashrc' to apply changes"
    log_info "You may need to run 'atuin register' to set up shell history sync"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
