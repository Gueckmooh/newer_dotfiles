#!/usr/bin/env bash
# -*-shell-script-*-

. "$COMMON_SCRIPT_PATH"

export PATH=$HOME/.nix-profile/bin:$PATH

DOOM_PATH="$XDG_CONFIG_HOME/emacs/bin/doom"

doom_install() {
    log "Running doom install..."

    $DOOM_PATH install --no-env
    if test $? -ne 0; then
        error "Failed to install doom"
        exit 1
    fi
    success "Doom installed succesfuly"
}

doom_sync() {
    log "Running doom sync..."

    $DOOM_PATH sync
    if test $? -ne 0; then
        error "Failed to sync doom"
        exit 1
    fi
    success "Doom sync succesfuly"
}


main() {
    welcome "Doom emacs configuraion"

    doom_install
    doom_sync
}

main "${@}"
