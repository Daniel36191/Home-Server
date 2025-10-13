{
  localipaddress,
  ...
}:
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 8082;
    allowedHosts = "${localipaddress}:8082,homarr.lillypond.local,lillypond.local";
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