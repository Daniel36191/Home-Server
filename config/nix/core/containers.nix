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
      daemon.settings = {
        features.cdi = true;
      };
      rootless.daemon.settings.features.cdi = true;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
  ];
}