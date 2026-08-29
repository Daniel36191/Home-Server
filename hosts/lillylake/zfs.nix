{
  ...
}:
let
  cfg = import ../../disko/lillylake/raid-config.nix;
in
{
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [ cfg.arrayName ];
    };
  };
  services.zfs.autoScrub.enable = true;
}
