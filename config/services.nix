{
  ## Static
  homepage = {
    enable = true;
    port = "54321";

    abbr = "Ho";
    homepage = false;
    icon = "homepage";

    default = true;
    domain = "home";
    secure = false;
    sockets = false;
  };
  portainer = {
    enable = true;
    port = "9443";

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
    port = "8006";

    abbr = "PX";
    homepage = true;
    icon = "proxmox";

    domain = "proxmox";
    secure = true;
    sockets = false;
  };
  craft = {
    enable = false;
    port = "8443";

    abbr = "CC";
    homepage = true;
    icon = "crafty-controller";

    domain = "crafty";
    secure = true;
    sockets = true;
  };
  syncthing = {
    enable = true;
    port = "8384";

    abbr = "ST";
    homepage = true;
    icon = "syncthing";

    domain = "syncthing";
    secure = false;
    sockets = true;
  };
  copyparty = {
    enable = true;
    port = "3923";

    abbr = "FS";
    homepage = true;
    icon = "copyparty";

    domain = "files";
    secure = false;
    sockets = true;
  };
  kasm = {
    enable = false;
    port = "3069";

    abbr = "KM";
    homepage = true;
    icon = "kasm";

    domain = "kasm";
    secure = true;
    sockets = true;
  };
  nextcloud = {
    enable = false;
    port = "8080";

    abbr = "NC";
    homepage = true;
    icon = "nextcloud";

    domain = "nextcloud";
    secure = true;
    sockets = true;
  };
  jellyfin = {
    enable = false;
    port = "8920";

    abbr = "JF";
    homepage = true;
    icon = "jellyfin";

    domain = "jellyfin";
    secure = true;
    sockets = true;
  };
}