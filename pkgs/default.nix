{ pkgs ? (import ../nixpkgs.nix) {  } }:

{
  tmux-utils = pkgs.callPackage ./tmux-utils {  };
  emacs-utils = pkgs.callPackage ./emacs-utils {  };
  udb = pkgs.callPackage ./udb {  };
  psreplay = pkgs.callPackage ./psreplay {  };
}
