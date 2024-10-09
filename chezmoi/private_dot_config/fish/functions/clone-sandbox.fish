function clone-sandbox
    # We tell argparse about -h/--help and -s/--second - these are short and long forms of the same option.
    # The "--" here is mandatory, it tells it from where to read the arguments.
    argparse h/help 'c/cluster=' u/update -- $argv
    # exit if argparse failed because it found an option it didn't recognize - it will print an error
    or return

    # If -h or --help is given, we print a little help text and return
    if set -ql _flag_help
        echo "clone-sandbox [-h|--help] [-c|--cluster] [-u|--update] [ARGUMENT ...]"
        return 0
    end

    if test (count $argv) -lt 1
        echo "clone-sandbox expects at least one argument"
        return 1
    end

    set --local cluster Bpolyspace_mbd
    if set -ql _flag_cluster
        set cluster $_flag_cluster
    end

    set -l alias "$argv[1]"
    set -l sandbox "$USER.$alias"
    set -l sandbox_path "/mathworks/devel/sbs/36/$sandbox"
    set -l sandbox_work_path "$HOME/work/$alias"

    # Cloning the new sandbox
    if set -ql _flag_update
        mw sbs update -alias "$alias"
        or return
    else
        mw -using Bmain sbs create -c "$cluster" -alias "$alias"
        or return
    end

    ln -s "$sandbox_path" "$sandbox_work_path"
    or return

    pushd "$sandbox_work_path"
    myvsproj
    popd
end
