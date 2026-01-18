{
  pkgs,
  ...
}:
{
  modules = {
    authentik = {
      enable = true;
      port = 3443;
      domain = "auth";
      public = true;

      abbr = "AU";
      homepage = true;
      icon = "authentik";

    };

    portainer = {
      enable = true;
      port = 9443;
      domain = "portainer";

      abbr = "PT";
      homepage = true;
      icon = "portainer";
    };

    proxmox = {
      enable = false;
      port = 8006;
      domain = "proxmox";

      abbr = "PX";
      homepage = true;
      icon = "proxmox";
    };

    syncthing = {
      enable = true;
      port = 8384;
      domain = "syncthing";

      abbr = "ST";
      homepage = true;
      icon = "syncthing";

    };

    copyparty = {
      enable = true;
      port = 3923;
      domain = "files";

      abbr = "FS";
      homepage = true;
      icon = "copyparty";
      
      owner = "copyparty";
      data-directory = "/services/copyparty/public"; ## Only the public folder listed here

    };

    home-assistant = {
      enable = false;
      port = 8123;
      domain = "home";

      abbr = "HA";
      homepage = true;
      icon = "home-assistant";
      
      data-directory = "/services/home-assistant";

      love-config-writeable = true; ## Set to true to edit dashboard in ui, copy file yaml file next to home-assistant.nix then rebuild.
      connectors = [

      ];
      lovelace-modules = with pkgs.home-assistant-custom-lovelace-modules; [
        mini-graph-card
      ];
    };

    homepage = {
      enable = true;
      port = 8125;

      default = true;
      domain = "homepage";
    };

    immich = {
      enable = true;
      port = 2283;

      data-directory = "/services/immich";
      owner = "immich";

      abbr = "IM";
      homepage = true;
      icon = "immich";

      domain = "immich";
      public = true;
    };

    minecraft = {
      enable = true;
      port = 25500;
    
      data-directory = "/services/minecraft/stary";
      runCommand = ''${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.4.0/unix_args.txt "$@"'';
    };
  };
}