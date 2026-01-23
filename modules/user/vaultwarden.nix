{
  config,
  lib,
  vars,
  ...
}:
with lib;
let 
  mod = config.modules.vaultwarden;
in 
{
  config = mkIf mod.enable {
    services.vaultwarden = {
      enable = true;
      domain = "${mod.domain}.${vars.sld}.${vars.tld}";
      configureNginx = if config.services.caddy.enable then false else true;
      backupDir = "${mod.data-directory}/backups";
      dbBackend = "sqlite";
      environmentFile = config.age.secrets."vaultwarden-admin-token".path;
      config = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = mod.port;
      };
    };
  };
}