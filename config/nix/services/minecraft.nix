 {
  pkgs,
  minecraftoverlay,
  ...
}:
{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/services/minecraft/servers";

    servers = {
      testing = {
        enable = true;
        # package = pkgs.vanillaServers.vanilla-1_18_2;
        package = pkgs.fabricServers.fabric-1_18_2;
        serverProperties = {
          server-port = 25565;
        };
        whitelist = {
          # daniel76548769 = "uuid";
        };
      };
    };
  };


  ## Add Packages from flake overlay
  nixpkgs.overlays = [ minecraftoverlay ];
}