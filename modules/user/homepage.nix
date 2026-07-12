{
  lib,
  vars,
  config,
  ...
}:
with lib;
let
  mod = config.modules.homepage;

  homepageServices = lib.filterAttrs (
    _: cfg: (cfg.enable or false) && (cfg.homepage.homepage or false)
  ) config.modules;

  capitalizeDomain =
    domain: lib.toUpper (builtins.substring 0 1 domain) + builtins.substring 1 999 domain;

  bookmarks = lib.mapAttrsToList (name: cfg: {
    "${capitalizeDomain cfg.proxy.domain}" = [
      {
        abbr = cfg.homepage.abbr;
        icon = cfg.homepage.icon;
        href = "https://${cfg.proxy.domain}.${vars.sld}.${if cfg.proxy.public then vars.tld else "local"}";
      }
    ];
  }) homepageServices;
in
{
  config = mkIf mod.enable {
    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      listenPort = mod.proxy.port;
      # allowedHosts = "something.local";
      allowedHosts = concatStrings [
        "${vars.localipaddress}:${builtins.toString mod.proxy.port},"
        "${mod.proxy.domain}.${vars.sld}.${if mod.proxy.public then vars.tld else "local"},"
        "${vars.sld}.${if mod.proxy.public then vars.tld else "local"}"
      ];
      # environmentFile = "";

      bookmarks = [
        {
          Services = bookmarks;
        }
      ];
    };
  };
}
