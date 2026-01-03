{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    arion

     ## Do install the docker CLI to talk to podman. 
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

  # virtualisation = {
  #   docker.enable = lib.mkForce false;
  #   containers.enable = true;
  #   podman = {
  #     enable = true;
  #     dockerCompat = true;
  #     defaultNetwork.settings.dns_enabled = true;
  #   };
  # };
}