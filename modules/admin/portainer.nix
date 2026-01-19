{
  lib,
  ...
}:
with lib;
let
  mod = config.modules.portainer;
in
{  
  config = mkIf mod.enable {
    services.portainer = {
      enable = true;
      version = "latest";
      openFirewall = true;
      port = mod.port;
    };
  };
}