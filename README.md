# Dotfiles SSH

A comprehensive dotfiles setup for Ubuntu servers with modern utility tools and configurations, managed with GNU Stow.

## Features

This repository provides:
- **Modern CLI Tools**: Replacements for traditional Unix tools with better features
- **Shell Configuration**: Enhanced zsh configuration with useful aliases and functions (zsh is set as default shell)
- **Git Configuration**: Optimized git settings and aliases
- **Terminal Multiplexer**: Tmux configuration for better terminal management
- **Pure Prompt**: Clean and minimal Starship prompt inspired by Pure
- **Neovim Configuration**: Modern Lua-based Neovim setup with essential configurations
- **GNU Stow Management**: Symlink-based dotfiles management for easy maintenance

## Included Tools

### Core Utilities
- **[bat](https://github.com/sharkdp/bat)** - A cat clone with syntax highlighting and Git integration
- **[eza](https://github.com/eza-community/eza)** - A modern replacement for ls with colors and icons
- **[fd](https://github.com/sharkdp/fd)** - A simple, fast and user-friendly alternative to find
- **[ripgrep (rg)](https://github.com/BurntSushi/ripgrep)** - A line-oriented search tool that recursively searches directories
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - A smarter cd command, inspired by z and autojump
- **[starship](https://github.com/starship/starship)** - A minimal, blazing-fast, and infinitely customizable prompt
- **[atuin](https://github.com/ellie/atuin)** - Magical shell history (configured without sync)
- **[fzf](https://github.com/junegunn/fzf)** - A command-line fuzzy finder
- **[delta](https://github.com/dandavison/delta)** - A syntax-highlighting pager for git and diff output

### Git and Docker Management
- **[lazygit](https://github.com/jesseduffield/lazygit)** - Simple terminal UI for git commands
- **[lazydocker](https://github.com/jesseduffield/lazydocker)** - The lazier way to manage everything docker

### Additional Tools
- **tmux** - Terminal multiplexer for managing multiple terminal sessions
- **htop** - Interactive process viewer
- **tree** - Directory structure visualization
- **jq** - Command-line JSON processor
- **ncdu** - Disk usage analyzer
- **tldr** - Simplified man pages
- **neofetch** - System information display
- **stow** - GNU Stow for symlink-based dotfiles management
- **neovim** - Modern text editor with Lua configuration

## Installation

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/joofio/dotfiles-ssh/main/install.sh | bash
```

### Manual Install

1. Clone this repository:
```bash
git clone https://github.com/joofio/dotfiles-ssh.git
cd dotfiles-ssh
```

2. Run the installation script:
```bash
chmod +x install.sh
./install.sh
```

3. Restart your shell or source the new configuration:
```bash
# The script will set zsh as your default shell
# You can start zsh immediately with:
zsh
# or source the new zsh configuration:
source ~/.zshrc
```

### Dotfiles Only

If you only want to install the configuration files without the utility tools:

```bash
chmod +x setup-dotfiles.sh
./setup-dotfiles.sh
```

## What Gets Installed

### System Packages
The script will install the following tools and their dependencies:
- All the modern CLI tools listed above
- Basic development tools (git, curl, wget, etc.)
- Terminal utilities (vim, nano, htop, tree, etc.)

### Configuration Files
The following dotfiles will be symlinked to your home directory using GNU Stow:
- `~/.zshrc` - Enhanced zsh configuration with aliases and functions (default shell)
- `~/.bashrc` - Enhanced bash configuration with aliases and functions (for compatibility)
- `~/.gitconfig` - Git configuration with useful aliases and enhanced delta settings
- `~/.tmux.conf` - Tmux configuration for better terminal management
- `~/.config/starship.toml` - Pure-style Starship prompt configuration
- `~/.gitignore_global` - Global gitignore patterns
- `~/.config/atuin/config.toml` - Atuin configuration with sync disabled
- `~/.config/fzf-config.sh` - FZF fuzzy finder configuration
- `~/.config/lazygit/config.yml` - Lazygit TUI configuration
- `~/.config/lazydocker/config.yml` - Lazydocker TUI configuration
- `~/.config/nvim/init.lua` - Modern Neovim configuration with Lua

## Configuration Details

### Shell Configuration
- **History**: Extended history with 20,000 entries for zsh, 10,000 for bash
- **Aliases**: Modern tool aliases (e.g., `ls` → `eza`, `cat` → `bat`)
- **Functions**: Useful functions for extracting archives, creating directories, etc.
- **Path**: Automatically adds `~/.local/bin` and `~/.cargo/bin` to PATH
- **Default Shell**: zsh is automatically set as the default shell during installation

### Git Configuration
- **Delta Integration**: Advanced diff visualization with syntax highlighting
- **Aliases**: Shortcuts for common git commands
- **Colors**: Colorized output for better readability
- **Default branch**: Set to `main`
- **Auto-setup**: Automatic remote tracking branch setup

### FZF Configuration
- **Modern Finder**: Fuzzy file finding with fd integration
- **Preview Support**: File preview with bat and directory preview with tree
- **Custom Key Bindings**: Enhanced navigation and selection
- **Color Scheme**: Consistent theming with other tools

### Docker Management
- **Lazydocker**: Visual container management with custom keybindings
- **Lazygit**: Git repository management with advanced TUI
- **Docker Aliases**: Quick shortcuts for common docker commands
- **Compose Integration**: Docker-compose workflow shortcuts

### Atuin Setup
- **Local History**: Enhanced shell history without cloud sync
- **Smart Search**: Fuzzy searching through command history
- **Privacy First**: No data sent to external servers
- **Cross-shell**: Works with both bash and zsh

### Tmux Configuration
- **Prefix**: Changed to `Ctrl-a` for easier access
- **Mouse support**: Enabled for easier pane management
- **Vi mode**: Vi-style key bindings for copy mode
- **Custom status bar**: Informative status line with time and date

### Starship Prompt
- **Pure-style prompt**: Clean, minimal two-line prompt layout inspired by Pure
- **Git integration**: Shows branch and status information with clean styling
- **Language detection**: Displays current programming language versions
- **Command duration**: Shows execution time for long-running commands
- **Optimized colors**: Carefully chosen colors for readability

## Customization

### GNU Stow Management
This repository uses GNU Stow for managing dotfiles through symlinks, making it easy to:
- Install/uninstall specific configurations
- Track changes in version control
- Avoid conflicts with existing files
- Maintain clean separation between different tools

#### Managing Packages
```bash
# Install specific package
cd dotfiles && stow <package-name> -t $HOME

# Remove specific package
cd dotfiles && stow -D <package-name> -t $HOME

# Reinstall package (useful after updates)
cd dotfiles && stow -R <package-name> -t $HOME
```

### Neovim Configuration
The included Neovim configuration provides:
- **Modern Lua setup**: Fast and extensible configuration
- **Essential keybindings**: Space as leader key with intuitive mappings
- **Smart defaults**: Line numbers, syntax highlighting, and proper indentation
- **Cross-platform compatibility**: Works on all systems where Neovim is available

### Git Configuration
Update the git configuration with your personal information:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Atuin Setup
Atuin is configured for local use only (no sync):
```bash
# History is stored locally in ~/.local/share/atuin/history.db
# Use Ctrl+R to search through history with fuzzy matching
# Use arrow keys to navigate, enter to select
```

### Docker Management Tools
Access powerful TUI tools for Docker management:
```bash
# Launch lazydocker for container management
lazydocker
# or use the alias
lzd

# Launch lazygit for git repository management  
lazygit
# or use the alias
lg
```

### FZF Integration
Enhanced file finding with fuzzy search:
```bash
# Use Ctrl+T to fuzzy find files
# Use Alt+C to fuzzy find directories
# Use Ctrl+R for enhanced history search (if atuin not available)
```

## Post-Installation

After installation, you may want to:
1. Restart your terminal or run `source ~/.bashrc`
2. Configure git with your personal information
3. Set up atuin for shell history sync (optional)
4. Customize the starship prompt configuration if desired

## Compatibility

This setup is designed for:
- Ubuntu 18.04 LTS and newer
- Zsh as the default shell (automatically installed and configured)
- Bash shell support for compatibility
- SSH server environments

## Contributing

Feel free to submit issues and enhancement requests! This is designed to be a practical, no-nonsense setup for server environments.

## License

This project is open source and available under the MIT License.
