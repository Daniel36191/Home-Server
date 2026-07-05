#! /usr/bin/env -S nix repl --extra-experimental-features "nix-command flakes" --file
let
  lib = (import <nixpkgs> { }).lib;

  # enabledServices = lib.filterAttrs (
  #   _: cfg: (cfg.enable or false) && (cfg.url or false)
  # ) config.modules;
in
{
  rr = 
}
