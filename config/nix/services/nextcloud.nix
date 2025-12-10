{
  pkgs,
  config,
  ...
}:
let
in
{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.lillypond.local";
    config = {
      adminuser = "admin";
      adminpassFile = config.age.secrets."copyparty-user-daniel".path;
    };

    ## App installs
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    extraAppsEnable = true;

  };
}



## Contacts
## Memories
