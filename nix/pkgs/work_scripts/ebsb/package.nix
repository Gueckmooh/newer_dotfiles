{
  stdenv,
  pkgs,
  fetchgit,
  fd,
}:

pkgs.python3Packages.buildPythonPackage {
  name = "ebsb";
  src = fetchGit {
    url = "ssh://git@insidelabs-git.mathworks.com/ebrignon/ebsb.git";
    rev = "cdf0808047ee19d90d4aef4a04473e37f1a89aa1";
  };

  propagatedBuildInputs = [
    # ...
    pkgs.python3Packages.setuptools
    pkgs.python3Packages.colorama
  ];

  buildInputs = [ fd ];

  postInstall = ''
    mkdir -p $out/bin

    for file in $(find "$src" -name __main__.py); do
      local target
      target=$(echo "$file" | xargs dirname | xargs basename)
      ln -s "$file" "$out/bin/$target"
      chmod u+x "$out/bin/$target"
    done
  '';
}
