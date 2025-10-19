{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "docker";
    docker = {
      enable = true;
      autoPrune.enable = true;
      rootless = {
        setSocketVariable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
  ];
}