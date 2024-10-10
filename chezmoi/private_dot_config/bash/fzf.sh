#!/bin/bash

# Auto-completion
# ---------------
source "$NIX_PROFILE/share/fzf/completion.bash"

# Key bindings
# ------------
source "$NIX_PROFILE/share/fzf/key-bindings.bash"

export FZF_CTRL_T_OPTS="--preview='highlight -O ansi --force -l {}' --preview-window=right,70%"
export FZF_TMUX_OPTS="-d 60%"

__ta_projects__() {
    if [[ -z "$TMUX" ]]; then
        ta -c ~/work/
    else
        local TA
        TA="$(which ta)"
        tmux popup -w30% -h30% -E "$TA -c ~/work/"
    fi
}

bind -m emacs-standard -x '"\C-g": __ta_projects__'
