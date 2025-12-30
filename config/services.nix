{
  ## Static
  homepage = { ## Service entry
    enable = true; ## Wether to enable the module
    port = 54321; ## What the ui port should be 

    abbr = "Ho"; ## Abbreavation for Homepage
    homepage = false; ## Wether to enable homepage entry
    icon = "homepage"; ## The icon from https://dashboardicons.com/ names pulled from https://github.com/homarr-labs/dashboard-icons/tree/main/svg

    default = true; ## Default entry for <hostname.local> when accessed *Can only be one set to true
    domain = "home"; ## The subdomain to <hostname.local> for url acess
    secure = false; ## Wether to use https for proxy
    sockets = false; ## Are websockets needed through proxy
  };
  portainer = {
    enable = true;
    port = 9443;

    abbr = "PT";
    homepage = true;
    icon = "portainer";

    domain = "portainer";
    secure = true;
    sockets = false;
  };

  ## Dynamic
  proxmox = {
    enable = false;
    port = 8006;

    abbr = "PX";
    homepage = true;
    icon = "proxmox";

    domain = "proxmox";
    secure = true;
    sockets = false;
  };
  crafty = {
    enable = false;
    port = 8443;

    abbr = "CC";
    homepage = true;
    icon = "crafty-controller";

    domain = "crafty";
    secure = true;
    sockets = true;
  };
  syncthing = {
    enable = true;
    port = 8384;

    abbr = "ST";
    homepage = true;
    icon = "syncthing";

    domain = "syncthing";
    secure = false;
    sockets = true;
  };
  copyparty = {
    enable = true;
    port = 3923;

    abbr = "FS";
    homepage = true;
    icon = "copyparty";

    domain = "files";
    secure = false;
    sockets = true;
  };
  kasm = {
    enable = false;
    port = 3069;

    abbr = "KM";
    homepage = true;
    icon = "kasm";

    domain = "kasm";
    secure = true;
    sockets = true;
  };
  nextcloud = {
    enable = false;
    port = 8080;

    abbr = "NC";
    homepage = true;
    icon = "nextcloud";

    domain = "nextcloud";
    secure = true;
    sockets = true;
  };
  jellyfin = {
    enable = false;
    port = 8920;

    abbr = "JF";
    homepage = true;
    icon = "jellyfin";

    domain = "jellyfin";
    secure = true;
    sockets = true;
  };
  immich = {
    enable = true;
    port = 2283;

    abbr = "IM";
    homepage = true;
    icon = "immich";

    domain = "immich";
    secure = true;
    sockets = true;
  };
}