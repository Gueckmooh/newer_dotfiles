function __ta_projects__
    set -l TA "$(which ta)"
    if set -q TMUX
        tmux popup -w30% -h30% -E "$TA -c $HOME/work/"
    else
        $TA -c "$HOME/work/"
    end
end

bind \cg '__ta_projects__'
