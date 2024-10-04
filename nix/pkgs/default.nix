{ pkgs ? import <nixpkgs> {  } }:

{
  scripts = pkgs.callPackage ./scripts {  };

  work_scripts = (import ./work_scripts) { };
}
