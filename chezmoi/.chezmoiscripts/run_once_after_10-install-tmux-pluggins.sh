#!/usr/bin/env sh
# -*-shell-script-*-

. "$COMMON_SCRIPT_PATH"

export PATH=$HOME/.nix-profile/bin:$PATH

INSTALL_PLUGGIN_SCRIPT="$XDG_CONFIG_HOME/tmux/plugins/tpm/scripts/install_plugins.sh"

install_tmux_pluggins() {
    log "Running install script.."
    bash "$INSTALL_PLUGGIN_SCRIPT"
    if test $? -ne 0; then
        error "Failed to install plugins"
        exit 1
    fi
    success "Tmux plugins installation successful"
}

main() {
    welcome "Tmux plugin configuration"

    install_tmux_pluggins
}

main "${@}"
