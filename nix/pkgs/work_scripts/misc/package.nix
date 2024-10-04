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
    cp run-single-kit-file.sh $out/bin/run-single-kit-file
    cp who-did-this $out/bin/.
    cp gdb-wrapper $out/bin/.
  '';
}
