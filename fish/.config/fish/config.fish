# ─── Environment Variables ────────────────────────────────────────────────────
# Disable the default greeting (use -g to avoid writing to universal variables on every shell launch)
set -g fish_greeting

# Editor setup
if type -q zed
    set -gx EDITOR "zed --wait"
    set -gx VISUAL "zed --wait"
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
    abbr --add fast fastfetch

    #Starfish
    starship init fish | source

    # ─── Abbreviations & Aliases ──────────────────────────────────────────────
    # To remove abbr run "abbr --erase <abbr>"
    # To list abbrs run "abbr --list"
    #
    # Navigation
    abbr --add .. "cd .."
    abbr --add ... "cd ../.."
    abbr --add .... "cd ../../.."

    # Files & Safety
    # Force confirmation on overwrites/deletes
    alias mv="mv -i"
    alias cp="cp -i"
    alias rm="rm -i"

    # Modern 'ls' replacement: 'eza', otherwise standard 'ls'
    if type -q eza
        alias ls="eza --icons --group-directories-first"
        alias ll="eza -l --icons --group-directories-first --git"
        alias la="eza -la --icons --group-directories-first --git"
        alias tree="eza --tree --icons"
    else
        alias ll="ls -l"
        alias la="ls -la"
    end

    # Modern 'cat' replacement
    if type -q bat
        alias cat="bat"
    end

    # Git (The Essentials)
    abbr --add g "git"
    abbr --add ga "git add"
    abbr --add gaa "git add ."
    abbr --add gc "git commit -m"
    abbr --add gca "git commit -am"
    abbr --add game "git commit --amend --no-edit"
    abbr --add gp "git push"
    abbr --add gf "git fetch --prune"
    abbr --add gu "git fetch --prune && git pull --rebase" #update project
    abbr --add gr "git pull --rebase" #rebase
    abbr --add gd "git diff"
    abbr --add grm "git branch -d" #rm branch
    abbr --add go "git checkout" #go to branch
    abbr --add gb "git branch"
    abbr --add gm "git merge"
    abbr --add gs "git stash"
    abbr --add gsp "git stash pop -q"
    abbr --add gres "git reset --hard HEAD"
    abbr --add gi "git status -s"
    abbr --add ghis "git log --oneline --graph --decorate --all" #git history

    # Docker
    abbr --add d "lazydocker"
    abbr --add dc "docker compose"
    abbr --add dup "docker compose up -d"
    abbr --add dwn "docker compose down"

    # Fly.io
    if type -q fly
        abbr --add fdeploy "fly deploy"
        abbr --add fstatus "fly status"
        abbr --add flogs "fly logs"
        abbr --add fssh "fly ssh console"
    end

    # Utils
    abbr --add pm "arch -arm64 brew" # Ghostty is not in the arm arch so I need to specify to brew what arch we are on
    abbr --add clr "clear"
    abbr --add keygen "openssl rand -base64" # do not forget to specify the length as arg
    abbr --add z "zed"
    abbr --add zh "zed ." #zed here
    alias conf="zed ~/dotconf"
    
    #docs
    abbr --add ffdoc "cat ~/dotconf/fish/.config/fish/fzf.txt"
    abbr --add gdoc "cat ~/dotconf/fish/.config/fish/git.txt"
    abbr --add fdoc "cat ~/dotconf/fish/.config/fish/fly.txt"
    abbr --add ddoc "cat ~/dotconf/fish/.config/fish/docker.txt"
    abbr --add udoc "cat ~/dotconf/fish/.config/fish/utils.txt"
    abbr --add ffmore "fzf_configure_bindings --help"

    # Reload Config
    abbr --add rld "source ~/.config/fish/config.fish"
end
