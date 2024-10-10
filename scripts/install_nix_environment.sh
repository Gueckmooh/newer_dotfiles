#!/usr/bin/env bash
#

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

. "$SCRIPT_DIR/common.sh"

ENVIRONMENT_SCRIPT="$(dirname ${SCRIPT_DIR})/nix/environment.nix"

WORK_FLAG=false
HELP_FLAG=false
DEBUG_FLAG=false

parse_args() {
    # Use getopt to parse options
    PARSED_OPTIONS=$(getopt -o wh --long work,help,debug -- "$@")
    if [ $? -ne 0 ]; then
        error "Failed to parse options."
        exit 1
    fi

    # Reorder the positional parameters according to getopt's output
    eval set -- "$PARSED_OPTIONS"

    # Process the options
    while true; do
        case "$1" in
            -w|--work)
                WORK_FLAG=true
                shift
                ;;
            -h|--help)
                HELP_FLAG=true
                shift
                ;;
            --debug)
                DEBUG_FLAG=true
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
    if [ "$HELP_FLAG" = true ]; then
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

    if [ "$WORK_FLAG" = true ]; then
        export INSTALL_WORK_PACKAGES=yes
    fi

    DEBUG_ARGS=
    if [ "$DEBUG_FLAG" = true ]; then
        DEBUG_ARGS="--show-trace"
    fi

    log "Installing nix environment.."
    nix-env -if "$ENVIRONMENT_SCRIPT" $DEBUG_ARGS
    if test $? -ne 0; then
        error "Failed to install nix environment"
        exit 1
    fi
    success "Nix environment installation successful"
}


main "${@}"
