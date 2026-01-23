# Dotfiles

A collection of configuration files for my development environment on macOS.

## 📦 Contents

- **Shell**: Fish (with Zoxide, Fastfetch, FZF)
- **Editor**: Zed
- **Terminal**: Ghostty
- **Tools**: GitHub CLI, Bat, Eza, Fly.io
- **System**: Raycast, OrbStack

## 🚀 Installation Guide

### 1. Prerequisites

Ensure you have [Homebrew](https://brew.sh/) installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone the Repository

Clone this repository to your home directory:

```bash
git clone https://github.com/yourusername/dotconf.git ~/dotconf
cd ~/dotconf
```

### 3. Install Dependencies

I use a `Brewfile` to manage all packages and applications. Run the following command to install everything (Fish, Zed, Fonts, CLI tools, etc.):

```bash
brew bundle
```

This will install:
- **Core**: git, fish, zoxide, fastfetch, fzf, eza, bat, gh, flyctl
- **Apps**: OrbStack, Zed, Ghostty, Raycast, Karabiner-Elements
- **Fonts**: JetBrains Mono Nerd Font (Required for terminal icons)

### 4. Link Configurations

You need to symlink the configuration files from this repo to your local config directory.

**Using GNU Stow (Recommended):**
If you have `stow` installed (`brew install stow`), you can simply run:

```bash
cd ~/dotconf
stow fish
stow zed
stow fastfetch
stow gh
```

### 5. Final Setup

#### Set Fish as Default Shell
1. Add fish to the list of allowed shells:
    ```bash
    echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
    ```
2. Change your default shell:
    ```bash
    chsh -s /opt/homebrew/bin/fish
    ```

#### Install Fish Plugins
Open a new terminal (now running Fish) and install the plugins managed by Fisher (they should auto-install, but if not):

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
```

## 🛠 Usage Tips

- **Listing Files**: `ls`, `ll`, `la` are aliased to `eza` for a modern view.
- **Git**: `g` (git), `gs` (status), `gc` (commit), `gp` (push), `gl` (log).
- **Fly.io**: `f` (fly), `fdeploy`, `fstatus`.
- **System Info**: Run `fastfetch` to see system stats.
- **Refresh Config**: Type `reload` to apply changes to `config.fish`.
