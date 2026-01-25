# ─── Environment Variables ────────────────────────────────────────────────────
# Disable the default greeting (use -g to avoid writing to universal variables on every shell launch)
set -g fish_greeting

# Editor setup
if type -q zed
    set -gx EDITOR "zed --wait"
end

# ─── Path & Integrations ──────────────────────────────────────────────────────

# 1. Homebrew (macOS)
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end

# 2. OrbStack
if test -f ~/.orbstack/shell/init.fish
    source ~/.orbstack/shell/init.fish 2>/dev/null || :
end

# 3. Zoxide (Better 'cd')
if type -q zoxide
    zoxide init fish --cmd cd | source
end

# 4. Fly.io
set -gx FLYCTL_INSTALL "$HOME/.fly"
if test -d "$FLYCTL_INSTALL/bin"
    fish_add_path "$FLYCTL_INSTALL/bin"
end

# ─── Interactive Session Only ─────────────────────────────────────────────────
if status is-interactive

    # Fastfetch (System Info)
    if type -q fastfetch
        fastfetch
    end
    abbr --add hyd fastfetch

    # ─── Abbreviations & Aliases ──────────────────────────────────────────────

    # Navigation
    abbr --add .. "cd .."
    abbr --add ... "cd ../.."
    abbr --add .... "cd ../../.."

    # Files & Safety
    # Force confirmation on overwrites/deletes
    alias mv="mv -i"
    alias cp="cp -i"
    alias rm="rm -i"

    # Modern 'ls' replacement: 'eza' (if installed), otherwise standard 'ls'
    if type -q eza
        alias ls="eza --icons --group-directories-first"
        alias ll="eza -l --icons --group-directories-first --git"
        alias la="eza -la --icons --group-directories-first --git"
        alias tree="eza --tree --icons"
    else
        alias ll="ls -l"
        alias la="ls -la"
    end

    # Modern 'cat' replacement: 'bat' (if installed)
    if type -q bat
        alias cat="bat"
    end

    # Git (The Essentials)
    abbr --add g "git"
    abbr --add gs "git status -s"
    abbr --add ga "git add"
    abbr --add gaa "git add ."
    abbr --add gc "git commit -m"
    abbr --add gca "git commit -am"
    abbr --add game "git commit --amend --no-edit"
    abbr --add gp "git push"
    abbr --add gf "git fetch"
    abbr --add gu "git fetch --prune && git pull --rebase"
    abbr --add gpl "git pull --rebase"
    abbr --add gd "git diff"
    abbr --add gdel "git branch -d"
    abbr --add go "git checkout"
    abbr --add gb "git branch"
    abbr --add gm "git merge"
    abbr --add gst "git stash"
    abbr --add gsp "git stash pop"

    # Docker
    abbr --add d "docker"
    abbr --add dc "docker compose"
    abbr --add dup "docker compose up"
    abbr --add dwn "docker compose down"

    # Fly.io
    if type -q fly
        abbr --add f "fly"
        abbr --add fdeploy "fly deploy"
        abbr --add fstatus "fly status"
        abbr --add flogs "fly logs"
        abbr --add fssh "fly ssh console"
    end

    # Utils
    abbr --add cl "clear"
    abbr --add ff "find . -type f | fzf"
    abbr --add keygen "openssl rand -base64"
    abbr --add z "zed"
    alias econf="ghostty +edit-config"

    # Reload Config
    abbr --add reload "source ~/.config/fish/config.fish"
end
