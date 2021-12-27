#!/usr/bin/env bash

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/rlambert/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/rlambert/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/rlambert/.fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/rlambert/.fzf/key-bindings.bash"
