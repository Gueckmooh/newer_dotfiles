#!/bin/sh

set -e




# # Check for needed binaries
# NEEDED_BINARIES="git curl xz sudo"
# for bin in $NEEDED_BINARIES; do
#     which "$bin" >/dev/null 2>&1
#     if test $? -ne 0 ; then
#         echo "Missing needed binary; make sure $NEEDED_BINARIES are installed"
#         exit 1
#     fi
# done

# mkdir -p "$HOME/.local/share"
# git clone https://github.com/gueckmooh/newer_dotfiles "$HOME/.local/share/chezmoi"
# mkdir -p /tmp/bin
# env PATH=/tmp/bin:$PATH sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp/bin init --apply


main() {
    check_needed_programs

    clone_dotfiles

    run_chezmoi
}

check_needed_programs() {
    echo caca
}

main "${@}"
