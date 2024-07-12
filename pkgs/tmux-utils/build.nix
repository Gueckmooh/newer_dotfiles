{ stdenv, lib, pkgs }:
let
  fs = lib.fileset;
  sourceFiles = fs.difference ./. (fs.maybeMissing ./result);
in

stdenv.mkDerivation {
  name = "tmux-utils";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp tn $out/bin
    cp ta $out/bin
    cp tk $out/bin
  '';
}
