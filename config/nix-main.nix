{
  pkgs,
  lib,
  services,
  ...
}:
{
  imports = [

    ##############
    ## Services ##
    ##############

    ./nix/tailscale.nix
    # ./nix/nginx.nix
    ./nix/caddy.nix

    ./nix/services/containers/minecraft.nix


    ##########
    ## Core ##
    ##########

    ./nix/apps.nix
    ../secrets/secrets-nix.nix
    ./nix/core/containers.nix
    ./nix/core/networking.nix
    ./nix/core/user.nix
    ./nix/core/boot.nix
    ./nix/core/hardware.nix
  ]
  ++ lib.optional (services.homepage.enable or false) ./nix/services/homepage.nix
  ++ lib.optional (services.portainer.enable or false) ./nix/services/containers/portainer.nix
  ++ lib.optional (services.proxmox.enable or false) ./nix/services/proxmox.nix
  ++ lib.optional (services.crafty.enable or false) ./nix/services/containers/crafty-compose2.nix
  ++ lib.optional (services.syncthing.enable or false) ./nix/services/syncthing.nix
  ++ lib.optional (services.copyparty.enable or false) ./nix/services/copyparty.nix
  ++ lib.optional (services.kasm.enable or false) ./nix/services/kasm.nix
  ++ lib.optional (services.nextcloud.enable or false) ./nix/services/nextcloud.nix
  ++ lib.optional (services.jellyfin.enable or false) ./nix/services/jellyfin.nix
  ++ lib.optional (services.immich.enable or false) ./nix/services/immich.nix
  ++ lib.optional (services.minecraft.enable or false) ./nix/services/containers/minecraft.nix
  ++ lib.optional (services.home-assistant.enable or false) ./nix/services/home-assistant.nix
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