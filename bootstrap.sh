#!/bin/sh

set -e


readonly YELLOW='\e[0;33m'
readonly GREEN='\e[0;32m'
readonly RED='\e[0;31m'
readonly RESET='\e[0m'

DOTFILES_REPOSITORY="https://github.com/gueckmooh/newer_dotfiles"

log() {
    printf "${YELLOW}>> %s${RESET}\n" "${*}"
}
success() {
    printf "${GREEN}>> %s${RESET}\n" "${*}"
}
error() {
    printf "${RED}>> %s${RESET}\n" "${*}" 1>&2
}

main() {
    echo "####################################################################"
    echo "###               GUECKMOOH'S CONFIG BOOTSTRAP                   ###"
    echo "###                                                              ###"
    echo "### Author: Enzo 'Gueckmooh' Brignon                             ###"
    echo "### Homepage: https://github.com/gueckmooh/newer_dotfiles        ###"
    echo "###                                                              ###"
    echo "####################################################################"

    check_needed_programs
    clone_dotfiles
    run_chezmoi
}

# Usage: check_needed_programs
#
# Checks that all the needed programs are present in the system to install the
# config.
# Those programs are:
# - `git` to clone the dotfiles repository
# - `curl` to download nix
# - `xz` to unpack nix distribution
# - `sudo` to install various things, including nix
check_needed_programs() {
    log "Checking that needed programs are present.."

    NEEDED_PROGRAMS=(git curl xz sudo)
    for bin in ${NEEDED_PROGRAMS[@]}; do
        which "$bin" >/dev/null 2>&1
        if test $? -ne 0 ; then
            error "Missing needed program $bin; make sure $NEEDED_PROGRAMS are installed"
            exit 1
        fi
    done
    success "Done checking programs!"
}

clone_dotfiles() {
    log "Cloning dotfiles.."
    mkdir -p "$HOME/.local/share"
    git clone "$DOTFILES_REPOSITORY" "$HOME/.local/share/chezmoi"
    success "Done cloning dotfiles!"
}

run_chezmoi() {
    log "Running chezmoi.."
    mkdir -p /tmp/bin
    env PATH=/tmp/bin:$PATH sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp/bin init --apply
    success "Done running chezmoi! Enjoy using your new config!"
}

main "${@}"
