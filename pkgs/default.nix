{ pkgs ? import <nixpkgs> {  } }:

{
  tmux-utils = pkgs.callPackage ./tmux-utils {  };
  emacs-utils = pkgs.callPackage ./emacs-utils {  };
  udb = pkgs.callPackage ./mathworks/udb {  };
  psreplay = pkgs.callPackage ./mathworks/psreplay {  };
  ebsb = pkgs.callPackage ./mathworks/ebsb {  };
  mw-misc = pkgs.callPackage ./mathworks/misc {  };
}
