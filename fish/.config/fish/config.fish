if status is-interactive
    # 1. Remove the default greeting
    set -U fish_greeting

    # 2. OrbStack Setup
    # OrbStack usually places its init script here. We check if it exists first.
    if test -f ~/.orbstack/shell/init.fish
        source ~/.orbstack/shell/init.fish 2>/dev/null || :
    end

    # 3. Zoxide (Replacting 'cd')
    # The '--cmd cd' flag tells zoxide to replace the standard 'cd' command
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end

    # 4. Fastfetch
    # Run this only if we are in a terminal that can display it clearly
    if type -q fastfetch
        fastfetch
    end

    # 5. FZF + Find Abbreviations
    # 'ff' will expand to a command that searches files with find and pipes to fzf
    abbr --add ff "find . -type f | fzf"
    
    
    # 6. Homebrew (Standard macOS Setup)
    if test -d /opt/homebrew
        eval (/opt/homebrew/bin/brew shellenv)
    end
    
    abbr --add cl clear
end
