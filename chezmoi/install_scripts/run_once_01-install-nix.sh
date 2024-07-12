#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile

nix-env -if $HOME/.local/share/chezmoi/environment.nix
