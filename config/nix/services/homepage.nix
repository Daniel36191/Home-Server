{
  config,
  lib,
  localipaddress,
  ...
}:
let
  addr = "lillypond.local";
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 54321;
    allowedHosts = "${localipaddress}:54321,home.${addr},${addr}";
    ## For Keys
    environmentFile = "
    ";

    bookmarks = let 
      

      services = [
        {
          enable = config.services.portiner.enable;
          abbr = "PT";
          icon = "portainer";
          url = "portiner";
          secure = true;
        }
      ];

      enabledBookmarks = lib.filterAttrs (_: services: services.enable) services;

      makeBookmarks = services: mkUrl: let 
        mkUrl = url: secure: "${if secure then "https" else "http"}://${url}.${addr}";
        s = services;
        in {
        "${s.name}" = [
          {
            abbr = s.abbr;
            icon = s.icon;
            href = mkUrl s.url s.secure;
          }
        ];
      };
    in [
      {
        WebUIs = [ ## Catagory
          makeBookmarks
        ];
      }

    ];

  };
}