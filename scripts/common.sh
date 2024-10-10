#!/bin/bash

readonly BLUE='\e[0;34m'
readonly YELLOW='\e[0;33m'
readonly GREEN='\e[0;32m'
readonly RED='\e[0;31m'
readonly RESET='\e[0m'

readonly XDG_CONFIG_HOME="$HOME/.config"
readonly CHEZMOI_CONFIG_PATH="$XDG_CONFIG_HOME/chezmoi"

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

# Usage: welcome <configuration step>
#
# Prints a welwome message that tells the user which step of the configuration
# is happening.
welcome() {
    printf "${BLUE}********************************************************************\n${RESET}"
    printf "${BLUE}*** %-60s ***\n${RESET}" "${*}"
    printf "${BLUE}********************************************************************\n${RESET}"
}
