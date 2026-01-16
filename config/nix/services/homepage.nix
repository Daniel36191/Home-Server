{
  lib,
  localipaddress,
  local-address,
  services,
  ...
}:
let
  mod = services.homepage;

  homepageServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && (cfg.homepage or false)
  ) services;
  
  capitalizeDomain = domain: 
    lib.toUpper (builtins.substring 0 1 domain) + builtins.substring 1 999 domain;
  
  bookmarks = lib.mapAttrsToList (name: cfg: {
    "${capitalizeDomain cfg.domain}" = [{
      abbr = cfg.abbr;
      icon = cfg.icon;
      href = "${if cfg.secure then "https" else "http"}://${cfg.domain}.${local-address}";
    }];
  }) homepageServices;
  
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = mod.port;
    allowedHosts = "${localipaddress}:${builtins.toString mod.port},${mod.domain}.${local-address}${if mod.default then ",${local-address}" else ""}";
    environmentFile = "";
    
    bookmarks = [
      {
        Services = bookmarks;
      }
    ];
  };
}
