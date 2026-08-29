{
  config,
  lib,
  hostsFolder,
  pkgs-unstable,
  host,
  ...
}:
with lib;
let
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
      port = (import path { }).modules.diskHealth.proxy.port or 8546;

      host = builtins.head (lib.dropEnd 1 (lib.drop (builtins.length segs - 2) segs));
    in
    {
      inherit
        host
        value
        ip
        port
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
  webUiPort = builtins.head (
    builtins.filter (port: port != null) (
      builtins.attrValues (
        builtins.mapAttrs (name: value: if value.value == true then value.port else null) parsedAttrs
      )
    )
  );
  mod = config.modules.diskHealth;
  log = "DEBUG";
in
{
  options.modules.diskHealth.settings = {
    webUiHost = mkOption { default = false; };
  };
  config = mkIf mod.enable {
    services.scrutiny = {
      enable = mod.settings.webUiHost;
      package = pkgs-unstable.scrutiny;

      settings = {
        log.level = log;
        web.listen = {
          host = "0.0.0.0";
          port = mod.proxy.port;
        };
      };

      collector = {
        enable = true;
        package = pkgs-unstable.scrutiny-collector;
        settings = {
          log.level = log;
          host.id = # Caps only first letter X3
            lib.toUpper (builtins.substring 0 1 host)
            + builtins.substring 1 (builtins.stringLength host - 1) host;
          api.endpoint = "http://${webUiIp}:${toString webUiPort}";
        };
      };
    };
  };
}
