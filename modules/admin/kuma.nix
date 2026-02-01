{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.kuma;
in
{
  config = mkIf mod.enable {
    services.uptime-kuma = {
      enable = true;
      appriseSupport = true;
      settings = {
        DATA_DIR = mod.data-directory;
        PORT = mod.port;
        HOST="127.0.0.1";
      };
    };
  };
}
