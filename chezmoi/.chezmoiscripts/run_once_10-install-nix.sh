#!/usr/bin/env bash
# -*-shell-script-*-

. "$COMMON_SCRIPT_PATH"

INSTALL_NIX_SCRIPT="$WORKING_TREE/scripts/install_nix.sh"
INSTALL_NIX_ENVIRONMENT_SCRIPT="$WORKING_TREE/scripts/install_nix_environment.sh"

main() {
    welcome "Nix environment configuration"

    export PATH=$HOME/.nix-profile/bin:$PATH

    if test ! -x "$HOME/.nix-profile/bin/nix-env"; then
        bash "$INSTALL_NIX_SCRIPT"
    fi

    if test $WORK_PROFILE = "true"; then
        EXTRA_OPTIONS="-w"
    fi
    bash "$INSTALL_NIX_ENVIRONMENT_SCRIPT" "$EXTRA_OPTIONS"
}

# main "${@}"
