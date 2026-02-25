#!/usr/bin/env bash

# Default to verbose restow (-vR). 
# You can pass arguments like -D to unstow all: ./stow-all.sh -D
FLAGS="${@:- -vR}"

for dir in */; do
    # Remove trailing slash
    dir=${dir%/}
    
    # Skip hidden directories (like .git)
    [[ "$dir" == .* ]] && continue
    
    echo "Working on $dir..."
    stow $FLAGS "$dir"
done
