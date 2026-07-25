#! /usr/bin/env -S nix repl --extra-experimental-features "nix-command flakes" --file
let
  lib = (import <nixpkgs> { }).lib;

  hostsFolder = ./hosts;

  nixFiles = builtins.filter (p: lib.hasSuffix "config.nix" (toString p)) (
    lib.filesystem.listFilesRecursive hostsFolder
  );
  parseFile =
    path:
    let
      str = toString path;
      segs = lib.splitString "/" str;
      value = (import path { }).modules.diskHealth.settings.webUiHost or false;
      ip = (import path { }).host.localIpAddress or "";

      host = builtins.head (lib.dropEnd 1 (lib.drop (builtins.length segs - 2) segs));
    in
    {
      inherit
        host
        value
        ip
        ;
    };
  parsedAttrs = builtins.listToAttrs (
    map (item: {
      name = item.host;
      value = item;
    }) (map parseFile nixFiles)
  );
  webUiIp = builtins.head (
    builtins.filter (ip: ip != null) (
      builtins.attrValues (
        builtins.mapAttrs (name: value: if value.value == true then value.ip else null) parsedAttrs
      )
    )
  );

in
{
  rr = webUiIp;

}
