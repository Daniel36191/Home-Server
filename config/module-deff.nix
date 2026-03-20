{
  lib,
  ...
}:
with lib;
let
  module-list = [
    "authentik"
    "portainer"
    "proxmox"
    "syncthing"
    "copyparty"
    "home-assistant"
    "homepage"
    "immich"
    "minecraft"
    "radicale"
    "vaultwarden"
    "kuma"
    "otterwiki"
  ];


  options = listToAttrs (map (name: {name = name; value = {
    ## * = Not always used

    enable = mkEnableOption "${name}";

    ## Proxy ##
    proxy = {
      enable = mkOption { default = true; }; ## Disable proxy entry
      port = mkOption { default = 0; }; ## *Port for main interface/service
      secure = mkOption { default = true; }; ## Use https
      domain = mkOption { default = "${name}"; }; ## Sld to use
      public = mkOption { default = false; }; ## Send through puclic tld
      default = mkOption { default = false; }; ## Redirected here if no sld provided or sld has no entry
    };

    ## Homepage ##
    homepage = mkOption { default = false; }; ## Enable homepage entry
    icon = mkOption { default = "${name}"; }; ## Icon from https://dashboardicons.com/
    abbr = mkOption {default = "${toUpper (substring 0 2 name)}"; }; ## Abbreavation for homepage

    ## Data/Service ##
    data-directory = mkOption { default = "/services/${name}"; }; ## Storage location
    owner = mkOption { default = "${name}"; }; ## *Data/Service owner
    backups = {
      enable = mkOption { default = false; }; ## Enable backups - Must have data-directory set
      include = mkOption { default = [ ]; }; ## Absolute paths as sting list
      exclude = mkOption { default = [ ]; }; ## RegEx strings list for excluding files from backups
    };

  }; }) module-list);
in
{
 options.modules = {} // options;
}
