{
  ## Static
  homepage = {
    enable = true;
    default = true;
    domain = "home";
    secure = false;
    port = "54321";
    sockets = false;
  };
  portainer = { 
    enable = true;
    domain = "portainer";
    secure = true;
    port = "9443";
    sockets = false;
  };

  ## Dynamic
  proxmox = {
    enable = true;
    domain = "proxmox";
    secure = true;
    port = "8006";
    sockets = false;
  };
  craft = { 
    enable = true;
    domain = "crafty";
    secure = true;
    port = "8443";
    sockets = true;
  };
  syncthing = { 
    enable = true;
    domain = "syncthing";
    secure = false;
    port = "8384";
    sockets = true;
  };
  copyparty = { 
    enable = true;
    domain = "files";
    secure = false;
    port = "3923";
    sockets = true;
  };
  kasm = { 
    enable = true;
    domain = "kasm";
    secure = true;
    port = "3069";
    sockets = true;
  };
  nextcloud = { 
    enable = true;
    domain = "nextcloud";
    secure = true;
    port = "8080";
    sockets = true;
  };
  jellyfin = { 
    enable = true;
    domain = "jellyfin";
    secure = true;
    port = "8920";
    sockets = true;
  };
}