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
    config.http.server_port = mod.port;
    configDir = "${mod.data-path}/config";
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

    lovelace = {
      mode = if mod.love-config-writeable then "storage" else "yaml";
    };
    lovelaceConfigWritable = mod.love-config-writeable;
    lovelaceConfigFile = if mod.love-config-writeable == false then ./lovelace.yaml else null;
  }
  ;
}