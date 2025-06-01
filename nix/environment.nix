let
  pkgs = (import ./nixpkgs.nix) { config = {}; overlays = []; };
  my-pkgs = (import ./pkgs) { };

  emacs = pkgs.emacs30.override {
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
    pkgs.ninja
    pkgs.conan

    # Config
    pkgs.chezmoi

    # Utilities
    # pkgs.bear
    pkgs.cloc
    pkgs.yt-dlp
    pkgs.exiftool
    pkgs.doxygen
    pkgs.joplin

    # Misc
    pkgs.asciiquarium
    pkgs.poppler_utils
    pkgs.texliveFull
    pkgs.rubber

    # Libraries
    pkgs.sqlite

    # Encryption
    pkgs.age

    # Dev
    # ===
    pkgs.git
    (pkgs.lib.hiPrio pkgs.cmakeWithGui)
    pkgs.cmakeCurses
    pkgs.libtool

    # C/C++
    # (pkgs.lib.hiPrio pkgs.gcc14)
    # pkgs.clang
    pkgs.libcxx
    # pkgs.clang-tools
    pkgs.llvmPackages_19.clang-tools
    pkgs.ccls
    pkgs.openssl

    # # Python
    # (pkgs.python3.withPackages(
    #     ps: with ps; [
    #         colorama
	#     sphinx-rtd-theme
	#     breathe
    #     ]))
    # pkgs.pipenv
    # pkgs.scons

    # Go
    pkgs.go
    pkgs.gopls
    pkgs.goimports-reviser

    # Rust
    pkgs.rustup

    # Javascript
    pkgs.nodejs_22

    # My scripts
    my-pkgs.scripts
    ] ++ (if install_work_packages
          then builtins.attrValues my-pkgs.work_scripts
          else []);
  };
in
{ inherit shellEnv; }
