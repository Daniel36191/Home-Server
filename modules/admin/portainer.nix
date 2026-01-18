{
  lib,
  ...
}:
with lib;
let
  mod = config.modules.portainer;
in
{
  options.modules.portainer = {
    enable = mkEnableOption "Portainer";
    port = mkOption { default = 9443; };
  };
  
  config = mkIf mod.enable {
    services.portainer = {
      enable = true;
      version = "latest";
      openFirewall = true;
      port = mod.port;
    };
  };
}