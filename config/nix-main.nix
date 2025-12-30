{
  pkgs,
  ...
}:
{
  imports = [

    ##############
    ## Services ##
    ##############

    # ./nix/services/proxmox.nix
    # ./nix/servives/minecraft.nix
    # ./nix/services/containers/crafty.nix
    ./nix/services/homepage.nix
    ./nix/services/syncthing.nix
    ./nix/services/copyparty.nix
    ./nix/services/tailscale.nix
    # ./nix/services/nextcloud.nix
    # ./nix/services/kasm.nix
    # ./nix/services/jellyfin.nix

    # ./nix/services/containers/crafty-compose2.nix
    # ./nix/services/containers/kasm-compose2.nix
    ./nix/services/containers/nextcloud-compose2.nix


    ##########
    ## Core ##
    ##########

    ./nix/apps.nix
    ../secrets/secrets-nix.nix
    ./nix/services/containers/portainer.nix
    ./nix/core/containers.nix
    ./nix/nginx.nix
    ./nix/core/networking.nix
    ./nix/core/user.nix
    ./nix/core/boot.nix
    ./nix/core/hardware.nix
  ];

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