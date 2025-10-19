{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
  ];
}