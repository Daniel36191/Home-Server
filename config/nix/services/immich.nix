{
  pkgs,
  config,
  services,
  ...
}:{
  environment.systemPackages = with pkgs; [
    immich-cli
  ];
  services.immich = {
    enable = true;
    openFirewall = true;
    port = services.immich.port;
    user = "immich";
    mediaLocation = "/services/immich";
    host = "0.0.0.0";

    machine-learning.enable = true; ## Dectect faces & objects
    accelerationDevices = [ "/dev/dri/renderD128" ];
  };
  systemd.tmpfiles.rules = [
      "d ${config.services.immich.mediaLocation} 0775 ${config.services.immich.user} users -"
  ];
}