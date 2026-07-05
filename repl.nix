#! /usr/bin/env -S nix repl --extra-experimental-features "nix-command flakes" --file
let
  lib = (import <nixpkgs> { }).lib;

  modulesFolder = ./modules;
  nixFiles = builtins.filter (p: lib.hasSuffix ".nix" (toString p)) (
    lib.filesystem.listFilesRecursive modulesFolder
  );
  parseFile =
    path:
    let
      str = toString path;
      relPath = builtins.elemAt (builtins.split "/modules/" str) 2;
      segs = lib.splitString "/" relPath;
      rest = builtins.tail segs; # drop section
      stem = lib.removeSuffix ".nix" (lib.last rest);
      group = if builtins.length rest > 1 then builtins.head rest else null;
    in
    {
      inherit stem group;
      depth = builtins.length rest;
    };
  parsed = map parseFile nixFiles;
  servicesList = lib.unique (map (p: p.stem) (builtins.filter (p: p.depth == 1) parsed));
in
{
  rr = servicesList;

}
