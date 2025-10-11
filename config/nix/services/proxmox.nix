{
  inputs,
  pkgs,
  proxmox-nixos,
  ...
}:
{
  services.proxmox-ve = {
    enable = true;
    package = inputs.proxmox-nixos.packages.${pkgs.system}.proxmox-nixos;
    ipAddress = "192.168.0.1";
  };

  # nixpkgs.overlays = [
  #   proxmox-nixos.overlays.${pkgs.system}
  # ];

  nix = {
    settings = {
      substituters = [
        "https://cache.saumon.network/proxmox-nixos"
      ];
      trusted-public-keys = [
        "proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM="
      ];
    };
  };
}