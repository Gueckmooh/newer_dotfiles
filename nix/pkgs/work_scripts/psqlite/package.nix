{
  stdenv,
  pkgs,
  fetchgit,
  buildGoModule
}:

buildGoModule {
  name = "psqlite";

  src = fetchGit {
    url = "ssh://git@insidelabs-git.mathworks.com/polyspace/tools/psqlite.git";
    submodules = true;
  };

  vendorHash = "sha256-AP+ngTiBweeAOQgyOytxuDKAlb5kNhuadHk20k/vQwE=";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/psqlite

    dir="$GOPATH/bin"
    [ -e "$dir" ] && cp "$dir/psqlitr" "$out/bin/."
  '';
}
