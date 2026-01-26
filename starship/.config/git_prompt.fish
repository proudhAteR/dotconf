#!/usr/bin/env fish

function superscript
    set -l input $argv[1]
    # Use string replace (builtin) instead of looping characters
    set input (string replace -a '0' '⁰' -- $input)
    set input (string replace -a '1' '¹' -- $input)
    set input (string replace -a '2' '²' -- $input)
    set input (string replace -a '3' '³' -- $input)
    set input (string replace -a '4' '⁴' -- $input)
    set input (string replace -a '5' '⁵' -- $input)
    set input (string replace -a '6' '⁶' -- $input)
    set input (string replace -a '7' '⁷' -- $input)
    set input (string replace -a '8' '⁸' -- $input)
    set input (string replace -a '9' '⁹' -- $input)
    set input (string replace -a '-' '⁻' -- $input)
    set input (string replace -a '+' '⁺' -- $input)
    echo -n $input
end

# We don't need to check 'git rev-parse' here because starship.toml's 'when' clause guarantees we are in a git repo.
# This saves one external command execution.

set -l git_out (git status --porcelain=v2 --branch --ignore-submodules=dirty 2>/dev/null)

if test $status -ne 0
    exit 0
end

# Optimization: Filter only the headers.
# This avoids looping over thousands of lines if you have many changed files.
set -l headers (string match "#*" -- $git_out)

set -l branch ""
set -l commit ""
set -l ahead 0
set -l behind 0
set -l dirty 0

# Check for dirty: If total lines > header lines, we have changes.
if test (count $git_out) -gt (count $headers)
    set dirty 1
end

for line in $headers
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
