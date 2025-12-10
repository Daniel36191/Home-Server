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
          name = "portainer";
          enable = config.services.portainer.enable or false;
          abbr = "PT";
          icon = "portainer";
          url = "portainer";
          secure = true;
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