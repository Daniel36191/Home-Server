{
  localipaddress,
  ...
}:
let
  guiPort = "8082";
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = guiPort;
    allowedHosts = "
    ${localipaddress}:${guiPort},
    home.lillypond.local,
    lillypond.local
    ";
    ## For Keys
    environmentFile = "
    ";

    bookmarks = [
      {
        Entertainment = [ ## Catagory
          {
            YouTube = [ ## Name
              {
                abbr = "YT";
                icon = "youtube"; ## Automactily from https://github.com/homarr-labs/dashboard-icons
                href = "https://youtube.com/"; ## Redirection url
              }
            ];
          }
        ];
      }

    ];

  };
}