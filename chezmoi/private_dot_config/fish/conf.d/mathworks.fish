#!/usr/bin/env fish

set -gx PST /mathworks/UK/devel/pst
set -gx DOOMDIR ~/.config/mwdoom

fish_add_path $PST/utils/bin
fish_add_path /mathworks/hub/share/apps/BuildTools/Linux/glibc-2.13/x86_64/perl/perl-5.34.1-mw-002/bin
fish_add_path -mp /mathworks/hub/share/sbtools/external-apps/llvm/llvm-19.1.4/install/deb12-64/bin/

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
    set -gx sbroot $current_sbroot
    set -gx r $sbroot

    set -g BACKUP_PATH $PATH
    set -a PATH $sbroot/matlab/polyspace/bin
    set -a PATH $sbroot/matlab/test/tools/polyspace/btv
    set -a PATH $sbroot/matlab/bin/glnxa64
end

function lk --description "Prints the link to the file so that one can open it in browser"
    printf "http://$(hostname).dhcp.mathworks.com%s\n" $(realpath $argv[1])
end

set -gx P4MERGE "emacs -init-directory $HOME/.config/emacs -u '' -nw -p4merge"
