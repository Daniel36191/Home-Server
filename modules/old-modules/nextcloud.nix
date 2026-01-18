

## Can't Pass Setup


{
  pkgs,
  config,
  services,
  ...
}:
let
  package = pkgs.nextcloud32;
in
{
  environment.systemPackages = [ package ]; ## Cli Tool
  services.nextcloud = {
    enable = true;
    home = "/services/nextcloud";
    package = package;
    configureRedis = true;
    appstoreEnable = false;
    maxUploadSize = "10G";
    hostName = "nextcloud.lillypond.local";
    database.createLocally = true;
    config = {
      adminuser = "admin";
      adminpassFile = config.age.secrets."nextcloud-user-admin".path;
      dbtype = "pgsql";
      dbuser = services.nextcloud.owner;
    };

    ## App installs
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar memories;
    };
    extraAppsEnable = true;

    settings.enabledPreviewProviders = [
      "OC\\Preview\\BMP"
      "OC\\Preview\\GIF"
      "OC\\Preview\\JPEG"
      "OC\\Preview\\Krita"
      "OC\\Preview\\MarkDown"
      "OC\\Preview\\MP3"
      "OC\\Preview\\OpenDocument"
      "OC\\Preview\\PNG"
      "OC\\Preview\\TXT"
      "OC\\Preview\\XBitmap"
      "OC\\Preview\\HEIC"
    ];
  };
  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    {
      addr = "127.0.0.1";
      port = services.nextcloud.port;
    }
  ];
}



## Contacts
## Memories
