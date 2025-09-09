# Dotfiles SSH

A comprehensive dotfiles setup for Ubuntu servers with modern utility tools and configurations.

## Features

This repository provides:
- **Modern CLI Tools**: Replacements for traditional Unix tools with better features
- **Shell Configuration**: Enhanced bash configuration with useful aliases and functions
- **Git Configuration**: Optimized git settings and aliases
- **Terminal Multiplexer**: Tmux configuration for better terminal management
- **Cross-shell Prompt**: Starship prompt for a modern, informative shell experience

## Included Tools

### Core Utilities
- **[bat](https://github.com/sharkdp/bat)** - A cat clone with syntax highlighting and Git integration
- **[eza](https://github.com/eza-community/eza)** - A modern replacement for ls with colors and icons
- **[fd](https://github.com/sharkdp/fd)** - A simple, fast and user-friendly alternative to find
- **[ripgrep (rg)](https://github.com/BurntSushi/ripgrep)** - A line-oriented search tool that recursively searches directories
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - A smarter cd command, inspired by z and autojump
- **[starship](https://github.com/starship/starship)** - A minimal, blazing-fast, and infinitely customizable prompt
- **[atuin](https://github.com/ellie/atuin)** - Magical shell history with sync capabilities

### Additional Tools
- **tmux** - Terminal multiplexer for managing multiple terminal sessions
- **htop** - Interactive process viewer
- **tree** - Directory structure visualization
- **jq** - Command-line JSON processor
- **ncdu** - Disk usage analyzer
- **tldr** - Simplified man pages
- **neofetch** - System information display

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
source ~/.bashrc
# or for zsh users
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
The following dotfiles will be copied to your home directory:
- `~/.bashrc` - Enhanced bash configuration with aliases and functions
- `~/.zshrc` - Enhanced zsh configuration with aliases and functions
- `~/.gitconfig` - Git configuration with useful aliases and settings
- `~/.tmux.conf` - Tmux configuration for better terminal management
- `~/.config/starship.toml` - Starship prompt configuration
- `~/.gitignore_global` - Global gitignore patterns

## Configuration Details

### Bash Configuration
- **History**: Extended history with 10,000 entries
- **Aliases**: Modern tool aliases (e.g., `ls` → `eza`, `cat` → `bat`)
- **Functions**: Useful functions for extracting archives, creating directories, etc.
- **Path**: Automatically adds `~/.local/bin` and `~/.cargo/bin` to PATH

### Git Configuration
- **Aliases**: Shortcuts for common git commands
- **Colors**: Colorized output for better readability
- **Default branch**: Set to `main`
- **Auto-setup**: Automatic remote tracking branch setup

### Tmux Configuration
- **Prefix**: Changed to `Ctrl-a` for easier access
- **Mouse support**: Enabled for easier pane management
- **Vi mode**: Vi-style key bindings for copy mode
- **Custom status bar**: Informative status line with time and date

### Starship Prompt
- **Multi-line**: Clean two-line prompt layout
- **Git integration**: Shows branch and status information
- **Language detection**: Displays current programming language versions
- **SSH indicator**: Shows hostname when connected via SSH

## Customization

### Git Configuration
Update the git configuration with your personal information:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Atuin Setup
If you want to sync shell history across machines:
```bash
atuin register
atuin login
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
- Bash and Zsh shells
- SSH server environments

## Contributing

Feel free to submit issues and enhancement requests! This is designed to be a practical, no-nonsense setup for server environments.

## License

This project is open source and available under the MIT License.
