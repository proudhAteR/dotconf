function superscript
    set -l map ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹
    set -l input $argv[1]
    set -l output ""
    for ch in (string split "" -- $input)
        switch $ch
            case 0 1 2 3 4 5 6 7 8 9
                set -l idx (math "$ch + 1")
                set output "$output$map[$idx]"
            case '-'
                set output "$output⁻"
            case '+'
                set output "$output⁺"
            case '*'
                set output "$output$ch"
        end
    end
    echo -n $output
end

function fish_prompt
    # Cache status and duration immediately
    set -l last_status $status
    set -l duration $CMD_DURATION

    # ─── Divider ──────────────────────────────────────────────
    # Dynamic width divider based on terminal columns
    set_color $fish_color_cwd
    echo '──────────────────────────────'
    set_color normal

    # ─── Info Line ────────────────────────────────────────────

    # Prompt Header (User @ Host)
    set_color $fish_color_user
    echo -n 'proudhater'
    set_color $fish_color_cwd
    echo -n '@'
    set_color $fish_color_host
    echo -n (prompt_hostname)' '

    # ─── Git Branch or Commit Info ────────────────────────────
    if type -q git; and git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)

        # Dirty Check (Uncommitted changes)
        set -l dirty (git status --porcelain --ignore-submodules=dirty 2>/dev/null)
        if test -n "$dirty"
            set branch "$branch*"
        end

        if test -z "$branch"
            # Detached HEAD
            set -l commit (git rev-parse --short HEAD 2>/dev/null)
            if test -n "$commit"
                set_color yellow
                echo -n "[detached@"(superscript "$commit")"] "
            end
        else
            # Ahead / Behind / Sync Check
            set -l upstream (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
            set -l ahead 0
            set -l behind 0

            if test -n "$upstream"
                set ahead (git rev-list --count @{u}..HEAD 2>/dev/null)
                set behind (git rev-list --count HEAD..@{u} 2>/dev/null)
            end

            # Force numeric safety
            set ahead (math "$ahead + 0")
            set behind (math "$behind + 0")

            # Determine color and format based on sync status
            set -l sync_status ""
            if test "$ahead" -gt 0 -a "$behind" -gt 0
                set_color yellow
                set sync_status (superscript "$ahead")"/"(superscript "$behind")
            else if test "$ahead" -gt 0
                set_color purple
                set sync_status (superscript "$ahead")
            else if test "$behind" -gt 0
                set_color $fish_color_user
                set sync_status (superscript "$behind")
            else
                set_color $fish_color_cwd
            end

            # Branch output
            echo -n "[$branch$sync_status] "
            set_color normal
        end
    end

    # ─── Prompt End ───────────────────────────────────────────
    set_color $fish_color_end
    echo -n "➤ "
    set_color normal
end


function fish_right_prompt
    set_color $fish_color_cwd
    # Path shortening inside home
    set -l current_dir (prompt_pwd)
    echo -n "$current_dir"

    set_color brblack
    echo -n " ╯"
    set_color normal
end
