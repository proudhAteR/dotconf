# Dotfiles Configuration

Welcome to my personal configuration files repository!

## ⚠️ Disclaimer

**I am by no means an expert.** I am just playing around and enjoying customizing my development environment. These configurations work for me, but please review them before using them on your own system. I am constantly learning and tweaking things, so expect changes!

## Prerequisites

To use these configurations effectively, you will need the following tools installed on your system. These dotfiles assume a macOS environment, but many configs will work on Linux as well.

### Core Shell & Terminal
*   **[Fish Shell](https://fishshell.com/)**: My primary shell.
*   **[Starship](https://starship.rs/)**: Cross-shell prompt.
*   **[Ghostty](https://mitchellh.com/ghostty)**: GPU-accelerated terminal emulator.
*   **[Fisher](https://github.com/jorgebucaran/fisher)**: Plugin manager for Fish (needed to install plugins listed in `fish_plugins`).
*   **[eza](https://eza.rocks/)**: A modern, maintained replacement for `ls`.
*   **[zoxide](https://github.com/ajeetdsouza/zoxide)**: A smarter `cd` command.
*   **[fzf](https://github.com/junegunn/fzf)**: A general-purpose command-line fuzzy finder.

### Editors & Tools
*   **[Zed](https://zed.dev/)**: High-performance text editor.
*   **[Bat](https://github.com/sharkdp/bat)**: A modern replacement for `cat`.
*   **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)**: System information fetching tool.
*   **[GitHub CLI (gh)](https://cli.github.com/)**: Official GitHub CLI tool.
*   **[Gemini CLI](https://github.com/google/generative-ai-python)**: For AI interactions.
*   **[Lazydocker](https://github.com/jesseduffield/lazydocker)**: A simple terminal UI for both docker and docker-compose.
*   **[OrbStack](https://orbstack.dev/)**: Fast, light, and easy way to run Docker containers and Linux machines on macOS.
*   **[Bun](https://bun.sh/)**: A fast all-in-one JavaScript runtime.
*   **[Docker purge](https://github.com/sam0rr/docker_purge.git)**: A tool created by a mistycal wizard to help me purge my docker cotainers.

### Fonts
*   **[Nerd Fonts](https://www.nerdfonts.com/)**: Essential for the icons in the Starship prompt and other CLI tools to render correctly. I recommend `JetBrains Mono Nerd Font` or `Hack Nerd Font`.

## Structure

This repository is structured for use with [GNU Stow](https://www.gnu.org/software/stow/).

*   `bat/`: Configuration for `bat`
*   `fastfetch/`: Configuration for `fastfetch`
*   `fish/`: Fish shell configuration, functions, and themes
*   `gemini/`: Configuration for Gemini
*   `gh/`: Configuration for GitHub CLI
*   `ghostty/`: Configuration for Ghostty
*   `starship/`: Starship prompt configuration
*   `zed/`: Zed editor settings and keymaps

## Installation

1.  Clone this repository to your dotfiles directory (e.g., `~/dotconf`).
2.  Install the prerequisites listed above.
3.  Use `stow` to symlink the configurations to your home directory.

```bash
cd ~/dotconf
stow fish
stow starship
stow bat
# ...and so on for other packages
```

Enjoy playing around with the configs!
