# Dotfiles Configuration

Welcome to my personal configuration files repository!

## ⚠️ Disclaimer

**I am by no means an expert.** I am just playing around and enjoying customizing my development environment. These configurations work for me, but please review them before using them on your own system. I am constantly learning and tweaking things, so expect changes!

## Prerequisites

To use these configurations effectively, you will need the following tools installed on your system. These dotfiles assume a macOS environment, but many configs will work on Linux as well.

Most prerequisites can be installed in one shot via the [Brewfile](#brewfile) below. The list here is for reference and for things Homebrew can't handle.

### Core Shell & Terminal
*   **[Fish Shell](https://fishshell.com/)**: My primary shell.
*   **[Starship](https://starship.rs/)**: Cross-shell prompt.
*   **[Ghostty](https://mitchellh.com/ghostty)**: GPU-accelerated terminal emulator.
*   **[Fisher](https://github.com/jorgebucaran/fisher)**: Plugin manager for Fish (needed to install plugins listed in `fish_plugins`).
*   **[eza](https://eza.rocks/)**: A modern, maintained replacement for `ls`.
*   **[zoxide](https://github.com/ajeetdsouza/zoxide)**: A smarter `cd` command.
*   **[fzf](https://github.com/junegunn/fzf)**: A general-purpose command-line fuzzy finder.
* **[fortune](https://jeffmilner.com/index.php/2023/09/19/fortune/)**: A classic Unix toy that prints a random quote, joke, or epigram. I use it to add a bit of personality to the terminal — and as the engine behind [`fortune-gca.sh`](#fortune-gcash), which uses its output as a commit message.

### Editors & Tools
*   **[Zed](https://zed.dev/)**: High-performance text editor.
*   **[Bat](https://github.com/sharkdp/bat)**: A modern replacement for `cat`.
*   **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)**: System information fetching tool.
*   **[GitHub CLI (gh)](https://cli.github.com/)**: Official GitHub CLI tool.
*   **[gh-dash](https://www.gh-dash.dev/getting-started/)**: Terminal dashboard for GitHub PRs and issues (installed as a `gh` extension).
*   **[Gemini CLI](https://github.com/google/generative-ai-python)**: For AI interactions.
*   **[Lazydocker](https://github.com/jesseduffield/lazydocker)**: A simple terminal UI for both docker and docker-compose.
*   **[OrbStack](https://orbstack.dev/)**: Fast, light, and easy way to run Docker containers and Linux machines on macOS.
*   **[Bun](https://bun.sh/)**: A fast all-in-one JavaScript runtime.
*   **[Docker purge](https://github.com/sam0rr/docker_purge.git)**: A tool created by a mistycal wizard to help me purge my docker cotainers.

### Fonts
*   **[JetBrains Mono Nerd Font](https://www.nerdfonts.com/)**: My daily driver. Required for icons in Starship, fastfetch, and the editor configs to render correctly. Installed via the Brewfile (`font-jetbrains-mono-nerd-font`).

## Brewfile

A [`Brewfile`](./Brewfile) lives at the root of the repo so a fresh machine can be bootstrapped in one command:

```bash
brew bundle install --file=~/dotconf/Brewfile
```

It pulls in the apps (Ghostty, Zed, OrbStack), the shell stack (fish, starship, bat, eza, fzf, zoxide, fastfetch), the tools used by my scripts (stow, fortune, lazydocker), GitHub tooling (`gh` + `gh-dash`), and the JetBrains Mono Nerd Font.

Things that can't go in a Brewfile (Fisher + fish plugins, Bun, Flyctl, the Stylus browser extension, the `gh-dash` extension itself) are documented as comments at the bottom of the file.

Other useful commands:

```bash
brew bundle check   --file=~/dotconf/Brewfile   # see what's missing
brew bundle cleanup --file=~/dotconf/Brewfile   # list installs not in the file
```

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
2.  Install the prerequisites with `brew bundle install --file=~/dotconf/Brewfile` (see [Brewfile](#brewfile)).
3.  Use `stow` to symlink the configurations to your home directory — the easiest way is the `stow-all.sh` helper described below.

```bash
cd ~/dotconf
./stow-all.sh           # restow every package in the repo
```

## Scripts

A handful of small shell scripts live at the root of the repo to make day-to-day life easier.

### `stow-all.sh`
Wraps GNU Stow so I don't have to call it once per package. By default it runs `stow -vR` against every top-level directory (skipping hidden ones like `.git`), which restows everything cleanly.

```bash
./stow-all.sh           # restow all packages (default: -vR)
./stow-all.sh -D        # unstow all packages
```

### `set-font.sh`
Applies a single font family across every config in the repo that cares about fonts (Ghostty, Zed, Stylus). It rewrites the primary font, so you can swap your daily driver in one command.

```bash
./set-font.sh "JetBrainsMonoNL Nerd Font Propo"
```

I keep it symlinked into `/usr/local/bin/set-font` so it's available as a system command:

```bash
ln -sf ~/dotconf/set-font.sh /usr/local/bin/set-font
set-font "IBM Plex Mono"
```

### `fortune-gca.sh`
Not really meant to be public, but I had too much fun with it to leave it out. It stages every modified file and commits them with a random [`fortune`](https://jeffmilner.com/index.php/2023/09/19/fortune/) quote as the message — perfect for the kind of commit that doesn't deserve a thoughtful message. Requires `fortune` (already in the Brewfile); browse `man fortune` if you want to swap in a specific cookie file (e.g. `fortune computers`, `fortune -s` for short ones).

```bash
./fortune-gca.sh
# → git commit -am "$(fortune)"
```

Sample output you might end up committing:

```
$ fortune
When in doubt, use brute force.
                -- Ken Thompson
```
(Yes, that's a real commit on this repo.)

Enjoy playing around with the configs!
