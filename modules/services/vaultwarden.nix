{
  config,
  lib,
  vars,
  pkgs-unstable,
  ...
}:
with lib;
let
  mod = config.modules.vaultwarden;
in
{
  config = mkIf mod.enable {
    services.vaultwarden = {
      package = pkgs-unstable.vaultwarden;
      enable = true;
      domain = "${mod.proxy.domain}.${vars.sld}.${vars.tld}";
      configureNginx = if config.services.caddy.enable then false else true;
      backupDir = "${mod.data.dataDirectory}/backups";
      dbBackend = "sqlite";
      environmentFile = config.age.secrets."vaultwarden-admin-token".path;
      config = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = mod.proxy.port;
      };
    };
  };
}
