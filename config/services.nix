{
  example = { ## Service entry
    enable = false; ## Wether to enable the module
    port = 8080; ## What the ui port should be 

    data-directory = "/services/example"; ## The Direcory of any sored data
    data-owner = "example-user"; ## The user who will own the data created

    abbr = "EX"; ## Abbreavation for Homepage
    homepage = true; ## Wether to enable homepage entry
    icon = "example"; ## The icon from https://dashboardicons.com/ names pulled from https://github.com/homarr-labs/dashboard-icons/tree/main/svg

    no-proxy = true; ## Dissable nginx entry
    default = false; ## Default entry for <hostname.local> when accessed *Can only be one set to true
    domain = "home"; ## The subdomain to <hostname.local> for url acess
    secure = false; ## Wether to use https for proxy
    sockets = false; ## Are websockets needed through proxy
  };

  ## Static
  homepage = {
    enable = true;
    port = 54321;

    abbr = "HO";
    homepage = false;
    icon = "homepage";

    default = true;
    domain = "home";
    secure = false;
    sockets = false;
  };
  portainer = {
    enable = false;
    port = 9443;

    abbr = "PT";
    homepage = true;
    icon = "portainer";

    domain = "portainer";
    secure = true;
    sockets = false;
  };

  ## Dynamic
  immich = {
    enable = true;
    port = 2283;

    data-directory = "/services/immich";
    data-owner = "immich";

    abbr = "IM";
    homepage = true;
    icon = "immich";

    domain = "immich";
    secure = false;
    sockets = true;
  };
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
    
    data-directory = "/services/copyparty/public"; ## Only the public folder listed here
    data-owner = "copyparty";

    domain = "files";
    secure = false;
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
  minecraft = {
    enable = true;
    port = 25500;
  
    data-directory = "/services/minecraft/stary";

    no-proxy = true;
  };



  ## Not Working Serives
  crafty = {
    enable = false;
    port = 8443;

    abbr = "CC";
    homepage = true;
    icon = "crafty-controller";

    data-directory = "/services/minecraft";
    data-owner = "crafty";

    domain = "crafty";
    secure = true;
    sockets = true;
  };
  nextcloud = {
    enable = false;
    port = 8080;

    abbr = "NC";
    homepage = true;
    icon = "nextcloud";

    data-directory = "/services/nextcloud";
    data-owner = "nextcloud";

    domain = "nextcloud";
    secure = true;
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
}