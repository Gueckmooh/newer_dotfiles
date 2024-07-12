#!/bin/bash

# Auto-completion
# ---------------
source "$NIX_PROFILE/share/fzf/completion.bash"

# Key bindings
# ------------
source "$NIX_PROFILE/share/fzf/key-bindings.bash"

export FZF_CTRL_T_OPTS="--preview='highlight -O ansi --force -l {}' --preview-window=right,70%"
export FZF_TMUX_OPTS="-d 60%"
