function superscript
    set map ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹
    set input $argv[1]
    set output ""
    for ch in (string split "" $input)
        switch $ch
            case 0 1 2 3 4 5 6 7 8 9
                set idx (math "$ch + 1")
                set output "$output$map[$idx]"
            case '-'
                set output "$output⁻"
            case '+'
                set output "$output⁺"
            case '*'
                set output "$output*"
            case '*'
                set output "$output$ch"
        end
    end
    echo -n $output
end



function fish_prompt
    # ─── Divider ──────────────────────────────────────────────
    set_color $fish_color_cwd
    echo '──────────────────────────────'
    set_color normal

    # ─── Prompt Header ────────────────────────────────────────
    set_color $fish_color_user
    echo -n 'proudhater'
    set_color $fish_color_cwd
    echo -n '@'
    set_color $fish_color_host
    echo -n (prompt_hostname)' ' 

    # ─── Git Branch or Commit Info ────────────────────────────
    if type -q git; and git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
        if test -z "$branch"
            # Detached HEAD
            set commit (git rev-parse --short HEAD 2>/dev/null)
            if test -n "$commit"
                set_color yellow
                echo -n "[detached@"(superscript "$commit")"] "
            end
        else
            # Ahead / Behind / Sync Check
            set upstream (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
            if test -n "$upstream"
                set ahead (git rev-list --count @{u}..HEAD 2>/dev/null)
                set behind (git rev-list --count HEAD..@{u} 2>/dev/null)
            else
                set ahead 0
                set behind 0
            end

            # Force numeric safety
            set ahead (math "$ahead + 0")
            set behind (math "$behind + 0")

            # Determine color and format
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
                set sync_status ""
            end

            # Branch output
            if test -n "$sync_status"
                echo -n "[$branch$sync_status] "
            else
                echo -n "[$branch] "
            end
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
    set current_dir (prompt_pwd)
    echo -n "$current_dir"

    set_color brblack
    echo -n " ╯"
    set_color normal
end
