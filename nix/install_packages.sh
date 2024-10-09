#!/usr/bin/env bash
#

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

# Get the directory of the script
script_dir=$(dirname "$(readlink -f "$0")")
environment_script="$script_dir/environment.nix"

work_flag=false
help_flag=false
debug_flag=false

parse_args() {
    # Use getopt to parse options
    PARSED_OPTIONS=$(getopt -o wh --long work,help,debug -- "$@")
    if [ $? -ne 0 ]; then
        echo "Failed to parse options." >&2
        exit 1
    fi

    # Reorder the positional parameters according to getopt's output
    eval set -- "$PARSED_OPTIONS"

    # Process the options
    while true; do
        case "$1" in
            -w|--work)
                work_flag=true
                shift
                ;;
            -h|--help)
                help_flag=true
                shift
                ;;
            --debug)
                debug_flag=true
                shift
                ;;
            --)
                shift
                break
                ;;
            *)
                echo "Unknown option: $1" >&2
                exit 1
                ;;
        esac
    done

    # Handle help option
    if [ "$help_flag" = true ]; then
        usage
        exit 0
    fi
}

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -w, --work    Enable work mode."
    echo "  -h, --help    Display this help message."
}

main() {
    parse_args "${@}"

    if [ "$work_flag" = true ]; then
        export INSTALL_WORK_PACKAGES=yes
    fi

    DEBUG_ARGS=
    if [ "$debug_flag" = true ]; then
        DEBUG_ARGS="--show-trace"
    fi

    log "Installing packages using nix.."
    nix-env -if "$environment_script" $DEBUG_ARGS
    if [ $? -ne 0 ]; then
        error "Error while installing packages"
        exit 1
    fi
    success "Done installing packages"
}


main "${@}"
