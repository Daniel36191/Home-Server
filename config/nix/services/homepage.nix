{
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

    bookmarks = [
      {
        WebUIs = [ ## Catagory
          {
            Portainer = [ ## Name
              {
                abbr = "PT";
                icon = "portainer"; ## Automactily from https://github.com/homarr-labs/dashboard-icons
                href = "https://portainer.${addr}/"; ## Redirection url
              }
            ];
            Proxmox = [
              {
                abbr = "PX";
                icon = "proxmox";
                href = "https://proxmox.${addr}/";
              }
            ];
            Crafty = [
              {
                abbr = "MC";
                icon = "crafty";
                href = "https://crafty.${addr}/";
              }
            ];
          }
        ];
      }

    ];

  };
}