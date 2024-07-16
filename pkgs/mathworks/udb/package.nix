{
  stdenv,
  ncurses,
}:

stdenv.mkDerivation {
  pname = "udb";
  version = "7.3.2";

  src = fetchTarball {
    url = https://download.undo.io/download/v1/e62d4912e0c4b4523794e968dfa59faf39f983ef32e4109f0e95d7c5/package/UDB-Corporate-x86;
    sha256 = "0hwim5mfpbhfwr2p338liz8p13rmlpzhlczza91l530xj2w4fr2x";
  };

  buildInputs = [ ncurses ];

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    mkdir -p $out/man/man1

    cp -r $src $out/lib/udb
    cp $src/udb.1 $out/man/man1
    ln -s $out/lib/udb $out/bin
  '';
}
