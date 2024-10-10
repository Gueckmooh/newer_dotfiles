# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) COLOR_PROMPT=yes;;
esac

__prompt_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ ──(\1)──/'
}

__prompt_path () {
    echo -n "${PWD/#$HOME/\~}" | awk -F "/" 'NF>4 { print $1"/"$2"/.../"$(NF-1)"/"$NF }
    NF<=4 { print $0 }'
}

__prompt_return_code () {
    ret=$?
    colored="$1"
    if [[ "$colored" = yes ]]; then
        if [[ $ret == 0 ]]; then
            color="setaf 2"
        else
            color="setaf 1"
        fi
    else
        color="sgr0"
    fi
    eval "tput $color" ; echo -n $ret
}

# ┌─[<return code>]<user>@<host>:<path>
# └─[<hour>]---$
if [[ "$COLOR_PROMPT" = yes ]]; then
    PS1="\[$(tput sgr0)\]┌─[\[\033[38;5;7m\]\$(__prompt_return_code yes)\[$(tput sgr0)\]]\[\033[38;5;1m\]\u\[$(tput sgr0)\]@\[\033[38;5;2m\]\h\[$(tput sgr0)\]:\[\033[38;5;63m\]\$(__prompt_path)\[$(tput sgr0)\]\[$(tput setaf 32)\]\$(__prompt_git_branch)\[$(tput sgr0)\]\n└─[\[\033[38;5;226m\]\A\[$(tput sgr0)\]]\[\033[38;5;1m\]---\[$(tput sgr0)\]\\$ "
else
    PS1="┌─[\$(__prompt_return_code)]\u@\h:\$(__prompt_path)\$(__prompt_git_branch)\n└─[\A]---\\$ "
fi

unset COLOR_PROMPT
