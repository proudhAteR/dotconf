#!/usr/bin/env fish

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

if type -q git; and git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l git_out (git status --porcelain=v2 --branch --ignore-submodules=dirty 2>/dev/null)
    set -l branch ""
    set -l commit ""
    set -l ahead 0
    set -l behind 0
    set -l dirty 0

    for line in $git_out
        set -l parts (string split " " -- $line)
        switch $parts[2]
            case "branch.head"
                set branch (string join " " $parts[3..-1])
            case "branch.oid"
                set commit (string sub -l 7 $parts[3])
            case "branch.ab"
                set ahead (string trim -c "+" -- $parts[3])
                set behind (string trim -c "-" -- $parts[4])
        end
        
        # Check for dirty (lines not starting with #)
        if not string match -q "#*" -- $line
            set dirty 1
        end
    end

    if test "$branch" = "(detached)"
        if test -n "$commit"
            echo -n "detached@"(superscript "$commit")
        end
    else
        if test "$dirty" -eq 1
             set branch "$branch*"
        end
        
        set -l sync_status ""
        if test "$ahead" -gt 0; and test "$behind" -gt 0
            set sync_status "⇡"(superscript "$ahead")"⇣"(superscript "$behind")
        else if test "$ahead" -gt 0
             set sync_status "⇡"(superscript "$ahead")
        else if test "$behind" -gt 0
             set sync_status "⇣"(superscript "$behind")
        end
        
        echo -n "$branch$sync_status"
    end
end