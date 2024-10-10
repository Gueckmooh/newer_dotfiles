#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

. "$SCRIPT_DIR/common.sh"

main() {
    log "Installing nix.."
    sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile
    if test $? -ne 0 ; then
        error "Failed to install nix"
        exit 1
    fi
    success "Nix installed succesfuly"
}

main "${@}"
