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
      port = 8443;
      secure = true;
      public = true;
      domain = "portainer";

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
      
      owner = "copyparty";
      data-directory = "/services/copyparty/public"; ## Only the public folder listed here
    };

    home-assistant = {
      enable = true;
      port = 8123;
      domain = "auto";

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
      public = true;
      secure = false;
      default = true;
    };

    immich = {
      enable = true;
      port = 2283;
      public = true;
      secure = false;

      homepage = true;

      data-directory = "/services/immich";
      owner = "immich";
    };

    minecraft = { ## Set rcon password in secrets
      enable = true;
      port = 25500;
      url = false;
    
      data-directory = "/services/minecraft/Create-Astral";
      owner = "minecraft";
      packName = "Create-Astral";
      autoStart = false;
      runArgs = ''-Xms6G -Xmx6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar --nogui'';
      javaPackage = pkgs.javaPackages.compiler.temurin-bin.jre-17;
    };

    radicale = {
      enable = true;
      port = 5232;
      secure = false;
      domain = "radicale";
      public = true;


      data-directory = "/services/radicale";
      owner = "radicale";
    };

    vaultwarden = {
      enable = true;
      port = 8222;
      secure = false;
      domain = "vault";
      public = true;

      data-directory = "/services/vaultwarden";
    };

    kuma = {
      enable = true;
      port = 8484;
      secure = false;
      domain = "kuma";
      public = true;

      data-directory = "/services/kuma";
    };
  };
}
