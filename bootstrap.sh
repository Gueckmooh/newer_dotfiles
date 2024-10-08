#!/bin/sh

set -e

DOTFILES_REPOSITORY="https://github.com/gueckmooh/newer_dotiles"



main() {
    check_needed_programs

    clone_dotfiles

    run_chezmoi
}

check_needed_programs() {
    # Check for needed binaries
    NEEDED_PROGRAMS="git curl xz sudo"
    for bin in $NEEDED_PROGRAMS; do
        which "$bin" >/dev/null 2>&1
        if test $? -ne 0 ; then
            echo "Missing needed program $bin; make sure $NEEDED_PROGRAMS are installed"
            exit 1
        fi
    done
}

clone_dotfiles() {
    mkdir -p "$HOME/.local/share"
    git clone "$DOTFILES_REPOSITORY" "$HOME/.local/share/chezmoi"
}

run_chezmoi() {
    mkdir -p /tmp/bin
    env PATH=/tmp/bin:$PATH sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp/bin init --apply
}

main "${@}"
