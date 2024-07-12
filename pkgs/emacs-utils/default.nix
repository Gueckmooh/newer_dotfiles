{
  system ? builtins.currentSystem,
}:
let
  pkgs = (import ../../nixpkgs.nix) { config = {}; overlays = []; inherit system; };
in

pkgs.callPackage ./build.nix { }
