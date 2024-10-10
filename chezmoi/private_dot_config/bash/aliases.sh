# -*-shell-script-*-

# alias l='ls -CF'
# alias ll='ls -CFlh'
# alias la='ls -ACF'
alias ls='eza --git --color=auto -F'
alias ll='eza --git --color=auto -F -l'
alias la='eza --git --color=auto -F -a'
alias pg='ps -e | grep $1'
alias emacs='emacs -init-directory "$XDG_CONFIG_HOME/emacs" -u ""'
alias ma='emacs -nw'
alias arm_ld='arm_none_eabi_ld -r -o'
alias c='caja . &'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias subl='sublime_text'
alias vlc-c='vlc --aout=alsa --alsa-audio-device=sysdefault:CARD=Device'
alias newtex='cp ~/Modèles/model_article.tex'
alias netbeans='netbeans --jdkhome /usr/lib/jvm/jdk-8-oracle-x64/ &'
alias wl='echo $[`ls -l | wc -l`-1]'
alias pres='evince -s'
alias sl='sl -e'
alias LS='LS -e'
alias yt-mini='(cd /home/brignone/Documents/yt-mini/yt-miniplayer && npm start)'
alias redshift0='redshift -m randr:crtc=0 &'
alias yt-dl='youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" -ci --embed-thumbnail --restrict-filenames'
alias yt-dl-playlist='youtube-dl --extract-audio --audio-format mp3 -o "%(playlist_index)s.%(title)s.%(ext)s" -ci --download-archive archive --embed-thumbnail --restrict-filenames'
alias france-inter='DISPLAY=:0.0 tilix -e nvlc http://direct.franceinter.fr/live/franceinter-midfi.mp3'
alias france-info='DISPLAY=:0.0 tilix -e nvlc  http://direct.franceinfo.fr/live/franceinfo-midfi.mp3'
alias ploop='find . -regextype posix-awk -regex ".*\.(cpp|h)" -exec cp {} ../control_cc/src/. \;'
# alias ntab='firefox --new-tab'
alias awkin='gawk -i inplace -v INPLACE_SUFFIX=.bak'
alias mpv='mpv --save-position-on-quit'
alias clipboard='xclip -selection clipboard'
alias lock='i3lock-fancy -f Courier -p -t Locked'
alias piper='PYTHONPATH=:/usr/lib/python3.5/site-packages piper'
alias icat='kitty +kitten icat'
alias cdscreen='[[ -d ~/Images/screenshots/$(date +%F)-screenshots ]] && cd ~/Images/screenshots/$(date +%F)-screenshots || echo "No screenshots taken today"'
# alias mpc='mpc -p 6601'
alias b='ranger'
alias xb='uxterm -e "source ~/.bash_profile && ranger"'

alias dcrypt='mkdir -p ~/crypt && encfs -i 5 ~/.crypt ~/crypt && cd ~/crypt'
alias look_away='cd && fusermount -u ~/crypt && rmdir ~/crypt'
# alias macl='emacsclient -nw -e "(create-scratch-buffer)" -e "(alpha-on-term)"'
alias compton-vsynco='compton --backend glx --paint-on-overlay --glx-no-stencil --vsync
 "opengl-swc" --unredir-if-possible --config /dev/null'
alias tomato-party='redshift'
alias lastfile='ls -t | head -1'
alias see='run-mailcap'
alias n='echo client.focus.minimized = true | awesome-client'
alias rgrep='grep -R'
alias mutt='neomutt'
alias kill-emacs='emacsclient --eval "(save-buffers-kill-emacs)"'
alias ns='netstat -nlptu'

alias autolock-off='kill -s SIGSTOP $(pgrep goautolock) 2> /dev/null'
alias autolock-on='kill -s SIGCONT $(pgrep goautolock) 2> /dev/null'

alias g=grep
alias gi='grep -i'


# fixcopyall='sbfixcopyright -f $(p4 opened | sed -e '"'"'s/#.*//g'"'"' -e '"'"'s/.*matlab/matlab/g'"'"')'

# X2X
alias x2x-home='TERM=xterm ssh -YC nia x2x -east -to :0.0'


# SSH
alias ssh="TERM=xterm-256color ssh"

# MathWorks
if [[ -f "$HOME/tools/bash_aliases" ]]
then
    . "$HOME/tools/bash_aliases"
fi

alias gocat='/usr/bin/cat'
alias cat='bat'
alias vim='nvim'
alias reload-kitty='pkill --signal SIGUSR1 kitty'
