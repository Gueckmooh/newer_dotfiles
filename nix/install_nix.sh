#!/usr/bin/env bash

readonly YELLOW='\e[0;33m'
readonly GREEN='\e[0;32m'
readonly RED='\e[0;31m'
readonly RESET='\e[0m'

log() {
    printf "${YELLOW}>> %s${RESET}\n" "${*}"
}
success() {
    printf "${GREEN}>> %s${RESET}\n" "${*}"
}
error() {
    printf "${RED}>> %s${RESET}\n" "${*}" 1>&2
}

script_dir=$(dirname "$(readlink -f "$0")")

main() {
    log "Installing nix.."
    sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile
    if [ $? -ne 0 ]; then
        error "Error while installing nix"
        exit 1
    fi
    success "Done installing nix"

    bash "$script_dir/install_packages.sh" "${@}"
}

main "${@}"
