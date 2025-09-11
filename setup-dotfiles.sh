#!/bin/bash

# Simple setup script to install dotfiles using GNU Stow
# Useful when you only want the configurations

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

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

# Check for potential stow conflicts
check_stow_conflicts() {
    local package="$1"
    local target_dir="$2"
    local conflicts=()
    
    # Use stow simulation mode to check for conflicts
    local stow_output
    stow_output=$(stow -n -v "$package" -t "$target_dir" 2>&1)
    local stow_exit_code=$?
    
    if [[ $stow_exit_code -ne 0 ]]; then
        # Parse conflicts from stow output
        while IFS= read -r line; do
            if [[ "$line" =~ existing\ target\ is\ neither\ a\ link\ nor\ a\ directory:\ (.+) ]]; then
                conflicts+=("${BASH_REMATCH[1]}")
            fi
        done <<< "$stow_output"
        
        if [[ ${#conflicts[@]} -gt 0 ]]; then
            return 1
        fi
    fi
    return 0
}

# Display conflicts and get user choice
handle_stow_conflicts() {
    local package="$1"
    local target_dir="$2"
    local conflicts=()
    local choice
    
    # Get list of conflicts
    local stow_output
    stow_output=$(stow -n -v "$package" -t "$target_dir" 2>&1)
    
    while IFS= read -r line; do
        if [[ "$line" =~ existing\ target\ is\ neither\ a\ link\ nor\ a\ directory:\ (.+) ]]; then
            conflicts+=("${target_dir}/${BASH_REMATCH[1]}")
        fi
    done <<< "$stow_output"
    
    if [[ ${#conflicts[@]} -eq 0 ]]; then
        return 0  # No conflicts
    fi
    
    log_warning "Package '$package' has conflicts with existing files:"
    for conflict in "${conflicts[@]}"; do
        log_warning "  - $conflict"
    done
    
    echo
    log_info "Choose an option:"
    echo "  [s] Skip this package"
    echo "  [b] Backup existing files and continue"
    echo "  [o] Overwrite existing files"
    echo "  [a] Abort installation"
    echo
    
    while true; do
        read -p "Your choice [s/b/o/a]: " choice
        case "$choice" in
            s|S)
                log_info "Skipping package '$package'"
                return 2  # Skip package
                ;;
            b|B)
                log_info "Backing up conflicting files..."
                local backup_dir="${target_dir}/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
                mkdir -p "$backup_dir"
                
                for conflict in "${conflicts[@]}"; do
                    if [[ -f "$conflict" ]] || [[ -d "$conflict" ]]; then
                        local rel_path="${conflict#$target_dir/}"
                        local backup_path="$backup_dir/$rel_path"
                        mkdir -p "$(dirname "$backup_path")"
                        mv "$conflict" "$backup_path"
                        log_success "Backed up $conflict to $backup_path"
                    fi
                done
                return 0  # Continue with stowing
                ;;
            o|O)
                log_warning "Removing conflicting files..."
                for conflict in "${conflicts[@]}"; do
                    if [[ -f "$conflict" ]] || [[ -d "$conflict" ]]; then
                        rm -rf "$conflict"
                        log_warning "Removed $conflict"
                    fi
                done
                return 0  # Continue with stowing
                ;;
            a|A)
                log_error "Installation aborted by user"
                exit 1
                ;;
            *)
                echo "Invalid choice. Please enter s, b, o, or a."
                ;;
        esac
    done
}

echo -e "${BLUE}Setting up dotfiles with GNU Stow...${NC}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if stow is available
if ! command -v stow >/dev/null 2>&1; then
    log_error "GNU Stow is not installed"
    echo -e "${BLUE}Please install stow first:${NC}"
    echo -e "  sudo apt install stow   # On Ubuntu/Debian"
    echo -e "  brew install stow       # On macOS"
    exit 1
fi

# Check if script directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    log_error "Script directory not found: $SCRIPT_DIR"
    exit 1
fi

# Change to script directory
cd "$SCRIPT_DIR" || {
    log_error "Could not change to script directory"
    exit 1
}

echo -e "${BLUE}Available packages:${NC}"
ls -1 */

echo

# First pass: check all packages for conflicts
log_info "Checking for potential conflicts..."
declare -a packages_with_conflicts=()
declare -a packages_clean=()

for package in */; do
    package_name=${package%/}
    # Skip non-package directories
    if [[ "$package_name" == ".git" ]]; then
        continue
    fi
    
    if check_stow_conflicts "$package_name" "$HOME"; then
        packages_clean+=("$package_name")
    else
        packages_with_conflicts+=("$package_name")
    fi
done

# Report conflicts summary
if [[ ${#packages_with_conflicts[@]} -gt 0 ]]; then
    log_warning "Found conflicts in ${#packages_with_conflicts[@]} package(s): ${packages_with_conflicts[*]}"
    log_info "Clean packages (${#packages_clean[@]}): ${packages_clean[*]}"
    echo
else
    log_success "No conflicts detected for any packages"
fi

# Stow all packages (handle conflicts interactively)
for package in */; do
    package_name=${package%/}
    # Skip non-package directories
    if [[ "$package_name" == ".git" ]]; then
        continue
    fi
    echo -e "${BLUE}📦 Processing package: $package_name${NC}"
    
    # Check for conflicts and handle them
    conflict_result=0
    if ! check_stow_conflicts "$package_name" "$HOME"; then
        handle_stow_conflicts "$package_name" "$HOME"
        conflict_result=$?
    fi
    
    case $conflict_result in
        0)
            log_info "Stowing package: $package_name"
            if stow -v "$package_name" -t "$HOME" 2>&1; then
                log_success "Successfully stowed $package_name"
            else
                log_error "Failed to stow $package_name"
            fi
            ;;
        2)
            log_info "Skipped package: $package_name"
            ;;
        *)
            log_error "Unexpected error handling conflicts for $package_name"
            ;;
    esac
    echo
done

log_success "Dotfiles setup complete!"
echo -e "${BLUE}Usage notes:${NC}"
echo -e "  To unstow a package: stow -D <package-name> -t \$HOME"
echo -e "  To restow a package: stow -R <package-name> -t \$HOME"
echo -e "  Backup files are stored in: ~/.dotfiles-backup/"
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Restart your shell or run: source ~/.bashrc"
echo -e "  2. Update git config with your name and email"
echo -e "  3. Install the utility tools with: ./install.sh"