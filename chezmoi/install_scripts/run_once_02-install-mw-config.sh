#!/bin/bash

readonly yellow='\e[0;33m'
readonly green='\e[0;32m'
readonly red='\e[0;31m'
readonly reset='\e[0m'

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

if [[ -d "$XDG_CONFIG_HOME/mathworks" ]]; then
    log "Skipping clone of mw config"
else
    log "Cloning mw config..."
    git clone git@insidelabs-git.mathworks.com:ebrignon/mwconfig.git "$XDG_CONFIG_HOME/mathworks"
fi
