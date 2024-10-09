{
  stdenv,
  pkgs,
  fetchgit,
  fd,
}:

pkgs.python3Packages.buildPythonPackage {
  name = "ebsb";
  src = fetchGit {
    url = "ssh://git@insidelabs-git.mathworks.com/polyspace/tools/find_internal_checker.git";
    rev = "400efd45e6fc560b44a4c02265ade639b62b6310";
  };

  propagatedBuildInputs = [
    # ...
    pkgs.python3Packages.setuptools
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
