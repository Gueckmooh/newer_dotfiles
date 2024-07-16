{ stdenv, lib }:
let
  fs = lib.fileset;
  sourceFiles = fs.difference ./. (fs.maybeMissing ./result);
in

stdenv.mkDerivation {
  name = "misc";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp myvsproj $out/bin/.
  '';
}
