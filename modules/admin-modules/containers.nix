{
  pkgs,
  lib,
  ...
}:
with lib;
let
  mod = config.moduels.containers;
in
{
  config = mkIf mod.enable {
    environment.systemPackages = with pkgs; [
      arion

      ## Not needed when virtualisation.docker.enable = true; ## https://docs.hercules-ci.com/arion/#_nixos
      docker-client

      # podman-compose
      docker-compose
    ];
    virtualisation = {
      containers.enable = true;
      oci-containers.backend = "docker";
      docker = {
        enable = lib.mkDefault true;
        autoPrune.enable = true;
        rootless = {
          enable = false;
          setSocketVariable = false;
        };
      };
    };

    virtualisation.arion = {
      backend = "docker";
    };
  };
}
