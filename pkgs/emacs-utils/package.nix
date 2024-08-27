{ stdenv, lib }:
let
  fs = lib.fileset;
  sourceFiles = fs.difference ./. (fs.maybeMissing ./result);
in

stdenv.mkDerivation {
  name = "emacs-utils";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp macl $out/bin
    cp me $out/bin
  '';
}
