let
  pkgs = (import ./nixpkgs.nix) { config = {}; overlays = []; };
  my-pkgs = (import ./pkgs) { };

  emacs = pkgs.emacs29.override {
    withNativeCompilation = true;
    withGTK3 = true;
  };
in
let
baseEnv = pkgs.buildEnv {
  name = "base-environment";
  paths = [
    pkgs.coreutils-full

    # Terminal
    emacs # if broken, install nscd
    pkgs.neovim
    pkgs.tmux
    pkgs.fzf

    # Config
    pkgs.chezmoi

    # Quality of life
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd

    # Encryption
    pkgs.age
  ];
};

devEnv = pkgs.buildEnv {
  name = "dev-environment";
  paths = [
    pkgs.git
    pkgs.cmake

    # C/C++
    (pkgs.lib.hiPrio pkgs.gcc)
    pkgs.clang
    pkgs.ccls

    # Python
    pkgs.python3
    pkgs.pipenv

    # Go
    pkgs.go
  ];
};

userEnv = pkgs.buildEnv {
  name = "user-environment";
  paths = [
    my-pkgs.tmux-utils
    my-pkgs.emacs-utils
    my-pkgs.udb
    my-pkgs.psreplay
    my-pkgs.ebsb
    pkgs.python3Packages.colorama
    my-pkgs.mw-misc
  ];
};
in
{
inherit baseEnv devEnv userEnv;
}
