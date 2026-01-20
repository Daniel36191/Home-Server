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

      homepage = true;
    };

    portainer = {
      enable = true;
      port = 9443;

      abbr = "PT";
      homepage = true;
    };

    proxmox = {
      enable = false;
      port = 8006;

      abbr = "PX";
      homepage = true;
    };

    syncthing = {
      enable = true;
      port = 8384;

      abbr = "ST";
      homepage = true;
    };

    copyparty = {
      enable = true;
      port = 3923;
      domain = "files";
      public = true;

      abbr = "FS";
      homepage = true;
      
      data-directory = "/services/copyparty/public"; ## Only the public folder listed here
    };

    home-assistant = {
      enable = false;
      port = 8123;
      domain = "home";

      abbr = "HA";
      homepage = true;
      
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
      domain = "home";
      secure = false;
      default = true;
    };

    immich = {
      enable = true;
      port = 2283;
      public = true;

      homepage = true;

      data-directory = "/services/immich";
      owner = "immich";
    };

    minecraft = {
      enable = false;
      port = 25500;
      url = false;
    
      data-directory = "/services/minecraft/stary";
      runCommand = ''${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.4.0/unix_args.txt "$@"'';
    };

    caldav = {
      enable = false;
      port = 5232;
      secure = true;
      domain = "caldav";
      public = true;

      data-directory = "/services/caldav"
    };
  };
}