{
  config,
  lib,
  localipaddress,
  ...
}:
let
  addr = "lillypond.local";
  port = "54321";
  mkUrl = url: secure: "${if secure then "https" else "http"}://${url}.${addr}";
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 54321;
    allowedHosts = "${localipaddress}:${port},home.${addr},${addr}";
    ## For Keys
    environmentFile = "";
    
    bookmarks = let
      services = [
        {
          name = "Portainer";
          enable = config.services.portainer.enable or false;
          abbr = "PT";
          icon = "portainer"; ## Automactily from https://github.com/homarr-labs/dashboard-icons
          url = "portainer";
          secure = true;
        }
        {
          name = "Proxmox";
          enable = config.services.proxmox-ve.enable or false;
          abbr = "PX";
          icon = "proxmox";
          url = "proxmox";
          secure = true;
        }
        {
          name = "Crafty Controller";
          enable = config.systemd.services."docker-crafty_container".enable or false;
          abbr = "PX";
          icon = "crafty-controller";
          url = "crafty";
          secure = true;
        }
        {
          name = "Files";
          enable = config.services.copyparty.enable or false;
          abbr = "copyparty";
          icon = "copyparty";
          url = "files";
          secure = false;
        }
      ];
      
      enabledServices = lib.filter (s: s.enable) services;
      
      makeBookmark = s: {
        abbr = s.abbr;
        icon = s.icon;
        href = mkUrl s.url s.secure;
      };
      
    in [
      {
        WebUIs = map (s: {
          "${s.name}" = [ (makeBookmark s) ];
        }) enabledServices;
      }
    ];
  };
}