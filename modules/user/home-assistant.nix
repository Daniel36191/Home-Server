{
  pkgs,
  lib,
  config,
  vars,
  ...
}:
with lib;
let
  mod = config.modules.home-assistant;
in
{
  options.modules.home-assistant = {
    enable = mkEnableOption "Home-Assistant";
    
    port = mkOption { default = 8123; };

    love-config-writeable = mkOption { default = false; };

    data-directory = mkOption { default = /services/home-assistant; };

    connectors = mkOption { default = []; };
    
    lovelace-modules = mkOption { default = []; };

  };

  config = mkIf mod.enable {
      services.home-assistant = {
      enable = true;
      openFirewall = true;
      config = {
        default_config = {};
        http.server_port = mod.port;
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "localhost"
          "${mod.domain}.${vars.sld}.${if mod.public then vars.tld else "local" }"
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
      ] ++ mod.connectors;
      customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
      ] ++ mod.lovelace-modules;

      lovelaceConfigWritable = mod.love-config-writeable;
      lovelaceConfigFile = if mod.love-config-writeable == false then ../extra-configs/home-assistant-lovelace.yaml else null;
    };
  };
}