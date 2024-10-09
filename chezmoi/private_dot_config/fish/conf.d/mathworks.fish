#!/usr/bin/env fish

fish_add_path /mathworks/UK/devel/pst/utils/bin
fish_add_path /mathworks/hub/share/apps/BuildTools/Linux/glibc-2.13/x86_64/perl/perl-5.34.1-mw-002/bin

function __update_sandbox_path --on-variable PWD --on-event config_ready --description "Updates path when in sandbox"
    set -l current_sbroot (command sbroot 2>/dev/null)
    or begin # remove the path if present
        not set -qg BACKUP_PATH
        and return

        set PATH $BACKUP_PATH
        set -e sbroot
        set -e r
        return
    end

    if set -qg sbroot
        return
    end
    set -g sbroot $current_sbroot
    set -g r $sbroot

    set -g BACKUP_PATH $PATH
    set -a PATH $sbroot/matlab/polyspace/bin
end
