{
  pkgs,
  lib,
  services,
  ...
}:
let
  sD = path: ./nix/services + path;
  cD = path : ./nix/services/containers + path;
  core = path: ./nix/core + path;
in 
{
  imports = [

    ##############
    ## Services ##
    ##############

    ./nix/tailscale.nix
    # ./nix/nginx.nix
    # ./nix/caddy.nix
    ./nix/cloudflared.nix


    ##########
    ## Core ##
    ##########

    ./nix/apps.nix
    ../secrets/secrets-nix.nix
    ( core /containers.nix)
    ( core /networking.nix)
    ( core /user.nix)
    ( core /boot.nix)
    ( core /hardware.nix)
  ]
  ++ lib.optional (services.homepage.enable or false) (sD /homepage.nix)
  ++ lib.optional (services.portainer.enable or false) (cD /portainer.nix)
  ++ lib.optional (services.proxmox.enable or false) (sD /proxmox.nix)
  ++ lib.optional (services.crafty.enable or false) (cD /crafty-compose2.nix)
  ++ lib.optional (services.syncthing.enable or false) (sD /syncthing.nix)
  ++ lib.optional (services.copyparty.enable or false) (sD /copyparty.nix)
  ++ lib.optional (services.kasm.enable or false) (sD /kasm.nix)
  ++ lib.optional (services.nextcloud.enable or false) (sD /nextcloud.nix)
  ++ lib.optional (services.jellyfin.enable or false) (sD /jellyfin.nix)
  ++ lib.optional (services.immich.enable or false) (sD /immich.nix)
  ++ lib.optional (services.minecraft.enable or false) (cD /minecraft.nix)
  ++ lib.optional (services.home-assistant.enable or false) (sD /home-assistant.nix)
  ++ lib.optional (services.duckdns.enable or false) (sD /duckdns.nix)
  ++ lib.optional (services.authentik.enable or false) (sD /authentik.nix)
  ;
  

  ###########
  ## Nixos ##
  ###########

  ## SSD partition cleanup
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  ## Compatibility
  system.activationScripts.binBash = ''
    ln -sf ${pkgs.bash}/bin/bash /bin/bash
  '';

  ## This value determines the NixOS release from which the default
  ## settings for stateful data, like file locations and database versions
  ## on your system were taken. It‘s perfectly fine and recommended to leave
  ## this value at the release version of the first install of this system.
  ## Before changing this value read the documentation for this option
  ## (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
}
