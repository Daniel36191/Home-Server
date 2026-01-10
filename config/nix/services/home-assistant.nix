{
  pkgs,
  lib,
  services,
  ...
}:
let
  mod = services.home-assistant;
in
{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    config = {
      http.server_port = mod.port;
      use_x_forwarded_for = true;
      trusted_proxies = [
        "127.0.0.1/24"
      ];
      http.server_host = [ "0.0.0.0" ];
      lovelace = {
        mode = if mod.love-config-writeable then "storage" else "yaml";
      };
    };
    configDir = "${mod.data-directory}/config";
    extraComponents = [
      ## Onboarding
      "esphome"
      "met"
      "radio_browser"
    ];
    customComponents = with pkgs.home-assistant-custom-components; [
      tuya_local
    ];
    customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
      mini-graph-card
    ];

    lovelaceConfigWritable = mod.love-config-writeable;
    lovelaceConfigFile = if mod.love-config-writeable == false then ./lovelace.yaml else null;
  }
  ;
}