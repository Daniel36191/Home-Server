{
  config,
  lib,
  localipaddress,
  servicesConfig,
  ...
}:
let
  addr = "lillypond.local";
  port = "54321";
  
  # Capitalize function
  capitalize = str: lib.toUpper (builtins.substring 0 1 str) + builtins.substring 1 999 str;
  
  # Create bookmark from service
  makeBookmark = name: cfg: {
    "${capitalize cfg.domain}" = [{
      abbr = cfg.abbr;
      icon = cfg.icon;
      href = "${if cfg.secure then "https" else "http"}://${cfg.domain}.${addr}";
    }];
  };
  
  # Filter and create bookmarks
  homepageBookmarks = lib.mapAttrsToList makeBookmark
    (lib.filterAttrs (_: cfg: cfg.enable && cfg.homepage) servicesConfig);
  
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 54321;
    allowedHosts = "${localipaddress}:${port},home.${addr},${addr}";
    environmentFile = "";
    
    bookmarks = [
      {
        Applications = homepageBookmarks;
      }
    ];
  };
}
