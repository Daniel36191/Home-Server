{
  proxmox-nixos,
  ...
}:{
  services.proxmox-ve = {
    enable = true;
    ipAddress = "192.168.0.1";
  };

  nixpkgs.overlays = [
    proxmox-nixos.overlays.${system}
  ];

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