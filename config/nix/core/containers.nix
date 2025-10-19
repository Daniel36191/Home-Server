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
      autoPrune.enable = true;
      dockerCompat = true;
    };
  };

  environment.systemPackages = with pkgs; [
  ];
}