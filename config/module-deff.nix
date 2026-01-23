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
  ];


  options = listToAttrs (map (name: {name = name; value = {
    enable = mkEnableOption "${name}";
    port = mkOption { default = 0; };
    secure = mkOption { default = true; };
    domain = mkOption { default = "${name}"; };
    public = mkOption { default = false; };
    default = mkOption { default = false; };
    url = mkOption { default = true; };

    abbr = mkOption {default = "${toUpper (substring 0 2 name)}"; };
    homepage = mkOption { default = false; };
    icon = mkOption { default = "${name}"; };

    owner = mkOption { default = "${name}"; };
    data-directory = mkOption { default = "/services/${name}"; };

  }; }) module-list);
in
{
 options.modules = {} // options;


  ## Desired output:
  #  options.modules.<service> = {
  #   abbr = mkOption {default = ""; };
  #   homepage = mkOption { default = false; };
  #   icon = mkOption { default = ""; };
  # };
}