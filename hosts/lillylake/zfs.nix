{
  ...
}:
let
  cfg = import ../../disko/lillylake/raid-config.nix;
in
{
  boot = {
  	supportedFilesystems = [ "zfs" ];
  	zfs.forceImportRoot = false;
  	};
  services.zfs.autoScrub.enable = true;
  fileSystems."${cfg.mountPoint}" = {
    device = cfg.arrayName;
    fsType = "zfs";
    ## Don't add mount options here, put then in disko.nix
  };
}
