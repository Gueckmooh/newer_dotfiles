#!/usr/bin/env fish

function macl
    set -l tmux_s (command tmux display-message -p "#S")

    set -l daemonize
    set -l socket
    if test $tmux_s != 0
        set daemonize --daemon=$tmux_s
        set socket --socket=$tmux_s
    else
        set daemonize --daemon
    end

    if test (command ps aux | grep "emacs.*$daemonize" | wc -l) -eq 1
        emacs $daemonize
    end

    if jobs | grep emacsclient >/dev/null 2>&1
        emacsclient $socket -n $argv
        fg '%emacsclient'
    else
        emacsclient $socket -nw $argv
    end
end
