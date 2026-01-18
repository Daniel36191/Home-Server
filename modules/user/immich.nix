{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.immich;
in
{
  options.modules.immich = {
    enable = mkEnableOption "Immich";

    port = mkOption { default =  };

    data-directory = mkOption { default = "/services/immich"; };

    owner = mkOption { default = "immich"; };
  };

  config = mkIf mod.enable {
    environment.systemPackages = with pkgs; [
      immich-cli
    ];
    services.immich = {
      enable = true;
      openFirewall = true;
      port = mod.port;
      user = mod.owner;
      group = "services";
      mediaLocation = mod.data-directory;
      host = "0.0.0.0";

      machine-learning.enable = true; ## Dectect faces & objects
      accelerationDevices = [ "/dev/dri/renderD128" ];
    };
    systemd.tmpfiles.rules = [
      "d ${config.services.immich.mediaLocation} 0775 ${config.services.immich.user} ${config.services.immich.group} -"
    ];
  };
}