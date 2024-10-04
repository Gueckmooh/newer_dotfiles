{ python3Packages }:
with python3Packages;

buildPythonPackage {
  name = "find-internal-checkers";
  src = ./.;

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
