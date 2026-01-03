{
  pkgs,
  ...
}:
{
  # virtualisation = {
  #   containers.enable = true;
  #   oci-containers.backend = "docker";
  #   docker = {
  #     enable = true;
  #     autoPrune.enable = true;
  #     rootless = {
  #       enable = false;
  #       setSocketVariable = false;
  #     };
  #   };
  # };


virtualisation = {
  docker.enable = lib.mkForce false;
  containers.enable = true;
  podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
};

  environment.systemPackages = with pkgs; [
    # docker-compose
    # docker-buildx

    podman-compose
  ];
}