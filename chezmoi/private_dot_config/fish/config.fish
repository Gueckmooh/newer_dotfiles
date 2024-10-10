if not status is-interactive
    return
end

set --global XDG_CONFIG_HOME $HOME/.config
set --global --export COLORTERM truecolor

set --global hydro_color_pwd $fish_color_cwd
set --global hydro_color_duration --dim $fish_color_command
set --global hydro_color_git yellow

set fish_greeting

# NIX
if test -e "$HOME/.nix-profile/etc/profile.d/nix.fish"
    source "$HOME/.nix-profile/etc/profile.d/nix.fish"
    set NIX_LINK $HOME/.nix-profile
    fish_add_path $NIX_LINK/bin

    set --global --export PYTHONPATH $NIX_LINK/lib/python3.11/site-packages
end

# FZF
if set -q NIX_LINK
    source "$NIX_LINK/share/fzf/key-bindings.fish"
    fzf_key_bindings
end

emit config_ready
