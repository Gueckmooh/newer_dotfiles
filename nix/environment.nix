let
  pkgs = (import ./nixpkgs.nix) { config = {}; overlays = []; };
  my-pkgs = (import ./pkgs) { };

  emacs = pkgs.emacs29.override {
    withNativeCompilation = true;
    withGTK3 = true;
  };
  install_work_packages = (builtins.getEnv "INSTALL_WORK_PACKAGES") == "yes";
in
let
  shellEnv = pkgs.buildEnv {
    name = "shell-environment";
    paths = [
    pkgs.coreutils-full
    pkgs.bash

    # Editors
    emacs
    pkgs.neovim

    # Terminal quality of life
    pkgs.tmux
    pkgs.fzf
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd
    pkgs.eza

    # Config
    pkgs.chezmoi

    # Utilities
    pkgs.bear
    pkgs.cloc
    pkgs.yt-dlp

    # Encryption
    pkgs.age

    # Dev
    # ===
    pkgs.git
    pkgs.cmake
    pkgs.libtool

    # C/C++
    (pkgs.lib.hiPrio pkgs.gcc)
    pkgs.clang
    pkgs.clang-tools
    pkgs.ccls
    pkgs.nodejs_22

    # Python
    pkgs.python3
    pkgs.pipenv

    # Go
    pkgs.go
    pkgs.gopls
    pkgs.goimports-reviser

    # My scripts
    my-pkgs.scripts
    ] ++ (if install_work_packages
          then builtins.attrValues my-pkgs.work_scripts
          else []);
  };
in
{ inherit shellEnv; }
