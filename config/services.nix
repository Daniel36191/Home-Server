{
  homepage = {
    domain = "home";
    secure = false;
    default = true;
    # port = "${config.homepage-dashboard.listenPort}";
    # enable = config.services.homepage-dashboard.enable or false;
  };
  portainer = { 
    domain = "portainer";
    secure = true;
    # enable = config.services.portainer.enable or false;
    # port = "${config.services.portainer.port}";
  };

  ## Dynamic
  proxmox = {
    domain = "proxmox";
    secure = true;
    # enable = config.services.proxmox-ve.enable or false;
    port = "8006";
  };
  craft = { 
    domain = "crafty";
    port = "8443";
    secure = true;
    sockets = true;
    # enable = config.systemd.services."docker-crafty_container".enable or false;
  };
  syncthing = { 
    domain = "syncthing";
    secure = false;
    sockets = true;
    port = "8384";
    # enable = config.systemd.user.services.syncthing.enable or false;
  };
  copyparty = { 
    domain = "files";
    secure = false;
    sockets = true;
    # port = "${config.services.copyparty.settings.p}";
    # enable = config.services.copyparty.enable or false;
  };
  kasm = { 
    domain = "kasm";
    secure = true;
    sockets = true;
    # port = "${config.services.kasmweb.listenPort}";
    # enable = config.services.kasmweb.enable or false;
  };
  nextcloud = { 
    domain = "nextcloud";
    secure = true;
    sockets = true;
    # port = "${config.services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen.port}";
    # enable = config.services.nextcloud.enable or false;
  };
  jellyfin = { 
    domain = "jellyfin";
    secure = true;
    sockets = true;
    port = "8920";
    # enable = config.services.jellyfin.enable or false;
  };
}