{
  pkgs,
  config,
  ...
}:
let
  nextcloud-version = "32";
in
{
  environment.systemPackages = with pkgs; [
    nextcloud"${nextcloud-version}"
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud"${nextcloud-version}";
    configureRedis = true;
    maxUploadSize = "10G";
    hostName = "nextcloud.lillypond.local";
    config = {
      adminuser = "admin";
      adminpassFile = config.age.secrets."nextcloud-user-admin".path;
      dbtype = "pgsql";
    };

    ## App installs
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
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
      port = 8080;
    }
  ];
}



## Contacts
## Memories
