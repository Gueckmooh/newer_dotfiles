# -*-shell-script-*-
#

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
    if [ -d "$HOME/.bashrc.d/completions" ]; then
        for file in "$HOME/.bashrc.d/completions/"*; do
            . "$file"
        done
    fi
    if [ -d "$HOME/.nix-profile/share/bash-completion/completions" ]; then
        for file in "$HOME/.nix-profile/share/bash-completion/completions/"*; do
            . "$file"
        done
    fi
fi
