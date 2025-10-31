{
  localipaddress,
  ...
}:
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 54321;
    allowedHosts = "${localipaddress}:54321,home.lillypond.local,lillypond.local";
    ## For Keys
    environmentFile = "
    ";

    bookmarks = [
      {
        Tooling = [ ## Catagory
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