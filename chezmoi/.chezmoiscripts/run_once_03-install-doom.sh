#!/bin/bash

set -e

readonly BLUE='\e[0;34m'
readonly YELLOW='\e[0;33m'
readonly GREEN='\e[0;32m'
readonly RED='\e[0;31m'
readonly RESET='\e[0m'

# Usage: info [ARG]...
#
# Prints all arguments on the standard output stream
info() {
    printf "${BLUE}%s${RESET}\n" "${*}"
}

# Usage: log [ARG]...
#
# Prints all arguments on the standard output stream
log() {
    printf "${YELLOW}>> %s${RESET}\n" "${*}"
}

# Usage: success [ARG]...
#
# Prints all arguments on the standard output stream
success() {
  printf "${GREEN} %s${RESET}\n" "${*}"
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf "${RED}!!! %s${RESET}\n" "${*}" 1>&2
}

export PATH=$HOME/.nix-profile/bin:$PATH

clone_personnal_config() {
    if [[ -d "$HOME/.config/doom" ]]; then
        log "Skipping doom personnal config clone"
    else
        log "Cloning personnal doom emacs config..."
        git clone git@github.com:Gueckmooh/doom-config $HOME/.config/doom
        if [[ "$?" == 0 ]]; then
            success "Clone successful"
        else
            error "Error occured while cloning personnal doom config"
            exit 1
        fi
    fi
}

doom_install() {
    log "Running doom install..."
    $HOME/.config/emacs/bin/doom install --no-env
    if [[ "$?" == 0 ]]; then
        success "Install successful"
    else
        error "Error occured while installing doom"
        exit 1
    fi
}

doom_sync() {
    log "Running doom sync..."
    $HOME/.config/emacs/bin/doom sync
    if [[ "$?" == 0 ]]; then
        success "Sync successful"
    else
        error "Error occured while syncing doom"
        exit 1
    fi
}


main() {
    info "********************************************************************"
    info "*** Install doom                                                 ***"
    info "********************************************************************"

    clone_personnal_config
    doom_install
    doom_sync
}

main "${@}"
