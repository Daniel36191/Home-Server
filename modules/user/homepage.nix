{
  lib,
  vars,
  config,
  ...
}:
with lib;
let
  mod = config.modules.homepage;

  homepageServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && (cfg.homepage or false)
  ) config.modules;
  
  capitalizeDomain = domain: 
    lib.toUpper (builtins.substring 0 1 domain) + builtins.substring 1 999 domain;
  
  bookmarks = lib.mapAttrsToList (name: cfg: {
    "${capitalizeDomain cfg.domain}" = [{
      abbr = cfg.abbr;
      icon = cfg.icon;
      href = "https://${cfg.domain}.${vars.sld}.${if cfg.public then vars.tld else "local"}";
    }];
  }) homepageServices;
in
{
  config = mkIf mod.enable {
    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      listenPort = mod.port;
      allowedHosts = "
        ${vars.localipaddress}:${builtins.toString mod.port},
        ${mod.domain}.${vars.sld}.${if mod.public then vars.tld else "local"}
        ${if mod.default then "${vars.sld}.${if mod.public then vars.tld else "local"}" else ""}";
      environmentFile = "";
      
      bookmarks = [
        {
          Services = bookmarks;
        }
      ];
    };
  };
}
