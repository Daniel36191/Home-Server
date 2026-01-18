{
  lib,
  vars,
  services,
  config,
  ...
}:
with lib;
let
  mod = config.modules.homepage;

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
  options.modules.homepage = {
    enable = mkEnableOption "Homepage";

    port = mkOption { default = 8125; };
  };

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
