{
  lib,
  localipaddress,
  services,
  ...
}:
let
  addr = "lillypond.local";
  port = "54321";
  
  homepageServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && (cfg.homepage or false)
  ) services;
  
  capitalizeDomain = domain: 
    lib.toUpper (builtins.substring 0 1 domain) + builtins.substring 1 999 domain;
  
  bookmarks = lib.mapAttrsToList (name: cfg: {
    "${capitalizeDomain cfg.domain}" = [{
      abbr = cfg.abbr;
      icon = cfg.icon;
      href = "${if cfg.secure then "https" else "http"}://${cfg.domain}.${addr}";
    }];
  }) homepageServices;
  
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = lib.strings.toInt port;
    allowedHosts = "${localipaddress}:${port},home.${addr},${addr}";
    environmentFile = "";
    
    bookmarks = [
      {
        Services = bookmarks;
      }
    ];
  };
}
