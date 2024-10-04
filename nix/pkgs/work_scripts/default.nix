{ pkgs ? import <nixpkgs> {  } }:

{
  ebsb = pkgs.callPackage ./ebsb {  };
  find-internal-checkers = pkgs.callPackage ./find-internal-checkers {  };
  misc = pkgs.callPackage ./misc {  };
  # psqlite = pkgs.callPackage ./psqlite {  }; @fixme
  psreplay = pkgs.callPackage ./psreplay {  };
  # udb = pkgs.callPackage ./udb {  }; @fixme
}
