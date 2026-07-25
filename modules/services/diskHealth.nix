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
          host.id =
            lib.toUpper (builtins.substring 0 1 host)
            + builtins.substring 1 (builtins.stringLength host - 1) host;
          api.endpoint = "http://${webUiIp}:${toString mod.proxy.port}";
        };
      };
    };
  };
}
