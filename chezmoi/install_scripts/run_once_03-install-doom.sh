#!/bin/bash

readonly yellow='\e[0;33m'
readonly green='\e[0;32m'
readonly red='\e[0;31m'
readonly reset='\e[0m'

export PATH=$HOME/.nix-profile/bin:$PATH

# Usage: log [ARG]...
#
# Prints all arguments on the standard output stream
log() {
  printf "${yellow}>> %s${reset}\n" "${*}"
}

# Usage: success [ARG]...
#
# Prints all arguments on the standard output stream
success() {
  printf "${green} %s${reset}\n" "${*}"
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf "${red}!!! %s${reset}\n" "${*}" 1>&2
}

# if [[ -d "$HOME/.config/emacs" ]]; then
#     log "Skipping doom emacs clone"
# else
#     log "Cloning doom emacs repository..."
#     git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
#     if [[ "$?" == 0 ]]; then
#         success "Clone successful"
#     else
#         error "Error occured while cloning doom"
#         exit 1
#     fi
# fi

# if [[ -d "$HOME/.config/doom" ]]; then
#     log "Skipping doom personnal config clone"
# else
#     log "Cloning personnal doom emacs config..."
#     git clone git@github.com:Gueckmooh/doom-config $HOME/.config/doom
#     if [[ "$?" == 0 ]]; then
#         success "Clone successful"
#     else
#         error "Error occured while cloning personnal doom config"
#         exit 1
#     fi
# fi

log "Running doom install..."
$HOME/.config/emacs/bin/doom install --no-env
if [[ "$?" == 0 ]]; then
    success "Install successful"
else
    error "Error occured while installing doom"
    exit 1
fi

log "Running doom sync..."
$HOME/.config/emacs/bin/doom sync
if [[ "$?" == 0 ]]; then
    success "Sync successful"
else
    error "Error occured while syncing doom"
    exit 1
fi
