#!/usr/bin/env bash

script_dir=$(dirname "$(readlink -f "$0")")
sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

bash "$script_dir/install_packages.sh" $@
