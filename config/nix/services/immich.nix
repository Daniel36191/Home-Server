{
  services,
  ...
}:{
  services.immich = {
    enable = true;
    openFirewall = true;
    port = services.immich.port;
    user = "immich";
    mediaLocation = /services/immich;

    machine-learning.enable = true; ## Dectect faces & objects
  };
}