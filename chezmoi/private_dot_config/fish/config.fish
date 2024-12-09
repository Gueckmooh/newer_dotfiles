if not status is-interactive
    return
end

set --global --export XDG_CONFIG_HOME $HOME/.config
set --global --export COLORTERM truecolor
set --global --export CPM_SOURCE_CACHE $HOME/.cache/CPM

set --global hydro_color_pwd $fish_color_cwd
set --global hydro_color_duration --dim $fish_color_command
set --global hydro_color_git yellow

set fish_greeting

# NIX
if test -e "$HOME/.nix-profile/etc/profile.d/nix.fish"
    source "$HOME/.nix-profile/etc/profile.d/nix.fish"
    set --global --export NIX_LINK $HOME/.nix-profile
    fish_add_path $NIX_LINK/bin

    set --global --export PYTHONPATH $NIX_LINK/lib/python3.11/site-packages
end

# FZF
if set -q NIX_LINK
    source "$NIX_LINK/share/fzf/key-bindings.fish"
    fzf_key_bindings
end

# In the case some executable could not be installed using nix:
fish_add_path $HOME/.local/share/install/bin

# Cargo
if test -e "$HOME/.cargo"
    set --global --export CARGO_HOME $HOME/.cargo
    fish_add_path $CARGO_HOME/bin
end

# Go
if test -e "$HOME/go"
    fish_add_path $HOME/go/bin
end

emit config_ready
