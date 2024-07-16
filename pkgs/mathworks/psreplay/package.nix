{
  stdenv,
  pkgs,
  fetchgit,
  buildGoModule
}:

buildGoModule {
  name = "psreplay";

  src = fetchGit {
    url = "ssh://git@insidelabs-git.mathworks.com/polyspace/tools/psreplay.git";
  };

  vendorHash = "sha256-JAJKYQNlQK/mkF1/6u/HEXuIucG+pFZjQKRnxf1+DhI=";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/psreplay

    dir="$GOPATH/bin"
    [ -e "$dir" ] && cp "$dir/psreplay" "$out/bin/."
    [ -e "$dir" ] && "$dir/tools" > "$out/share/psreplay/completion.bash"
  '';
}
