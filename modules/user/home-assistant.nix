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
  options.modules.home-assistant.settings = {
    love-config-writeable = mkOption { default = false; };

    connectors = mkOption { default = [ ]; };

    lovelace-modules = mkOption { default = [ ]; };
  };

  config = mkIf mod.enable {
    services.home-assistant = {
      enable = true;
      openFirewall = true;
      config = {
        default_config = { };
        http.server_port = mod.proxy.port;
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "localhost"
          "${mod.proxy.domain}.${vars.sld}.${if mod.proxy.public then vars.tld else "local"}"
        ];
        http.server_host = [ "0.0.0.0" ];
        lovelace = {
          mode = if mod.settings.love-config-writeable then "storage" else "yaml";
        };
      };
      configDir = "${mod.data.data-directory}/config";
      extraComponents = [
        ## Onboarding
        "esphome"
        "met"
        "radio_browser"
      ];
      customComponents =
        with pkgs.home-assistant-custom-components;
        [
        ]
        ++ mod.settings.connectors;
      customLovelaceModules =
        with pkgs.home-assistant-custom-lovelace-modules;
        [
        ]
        ++ mod.settings.lovelace-modules;

      lovelaceConfigWritable = mod.settings.love-config-writeable;
      lovelaceConfigFile =
        if mod.settings.love-config-writeable == false then
          ../extra-configs/home-assistant-lovelace.yaml
        else
          null;
    };
  };
}
