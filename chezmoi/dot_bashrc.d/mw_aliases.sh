# -*- shell-script -*-

alias lss='mw -using Bpolyspace_core sbs list'
alias ccore='mw -using Bpolyspace_core sbs -c Bpolyspace_core -alias'
alias cmbd='mw -using Bpolyspace_mbd sbs -c Bpolyspace_mbd -alias'
alias cclang='mw -using Bpolyspace_lang sbs -c Bpolyspace_lang -alias'
alias lk='echo -n "http://$(hostname).dhcp.mathworks.com" && realpath $1'
alias make-clang-format='eval "$(sbindent -disp-clang-format-cmd) --dump-config" > .clang-format'
# alias setsuiftime="PST_VAR_NO_STUBS=\`/home/tbidault/bin/gettime_s.sh\`; export PST_VAR_NO_STUBS"
alias npve="polyspace -pve -open-new-window"
alias sbsubmit="sbsubmit -no-clickable-shell"
alias btv-compare-run="btv-compare-run -mail ebrignon@mathworks.com"
alias cdr="cd $SBROOT"
alias sbcheck="sbcheck -no-clickable-shell"
alias new-story="python3 /local-ssd/ebrignon/dev/devt_eric/python/newStory.py -t ~/.config/jira/my_token"
alias sbsmartbuild-fast="sbsmartbuild -opened -k -distcc-pump -override-sandbox-requirements -no-sbsyscheck -turbo -no-ch-validate -no-regenerate-smart-mk -cache"
