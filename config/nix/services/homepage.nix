{
  config,
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

        (
          if config.services.portainer.enable == true then
          {
            Portainer = [ ## Name
              {
                abbr = "PT";
                icon = "portainer"; ## Automactily from https://github.com/homarr-labs/dashboard-icons
                href = "https://portainer.${addr}/"; ## Redirection url
              }
            ];
          }
          else ""a
        )
          {
            Proxmox = [
              {
                abbr = "PX";
                icon = "proxmox";
                href = "https://proxmox.${addr}/";
              }
            ];
          }
          {
            Crafty = [
              {
                abbr = "MC";
                icon = "crafty-controller";
                href = "https://crafty.${addr}/";
              }
            ];
          }
          {
            CopyParty = [
              {
                abbr = "Files";
                icon = "copyparty";
                href = "https://files.${addr}/";
              }
            ];
          }
        ];
      }

    ];

  };
}