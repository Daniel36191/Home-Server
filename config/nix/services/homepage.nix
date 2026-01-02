{
  lib,
  localipaddress,
  address,
  services,
  ...
}:
let
  
  homepageServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && (cfg.homepage or false)
  ) services;
  
  capitalizeDomain = domain: 
    lib.toUpper (builtins.substring 0 1 domain) + builtins.substring 1 999 domain;
  
  bookmarks = lib.mapAttrsToList (name: cfg: {
    "${capitalizeDomain cfg.domain}" = [{
      abbr = cfg.abbr;
      icon = cfg.icon;
      href = "${if cfg.secure then "https" else "http"}://${cfg.domain}.${address}";
    }];
  }) homepageServices;
  
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = services.homepage.port;
    allowedHosts = "${localipaddress}:${builtins.toString services.homepage.port},home.${address},${address}";
    environmentFile = "";
    
    bookmarks = [
      {
        Services = bookmarks;
      }
    ];
  };
}
