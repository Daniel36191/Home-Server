let
  cfg = import ./raid-config.nix;
  diskArray = builtins.mapAttrs (name: value: {
    type = "disk";
    device = "/dev/disk/by-id/${value}";
    content = {
      type = "gpt";
      partitions = {
        zfs-part = {
          size = "100%";
          content = {
            type = "zfs";
            pool = cfg.arrayName;
          };
        };
      };
    };
  }) cfg.driveList;

  raidArray = {
    disk = diskArray;
    zpool = {
      "${cfg.arrayName}" = {
        type = "zpool";
        mode = "raidz1";
        rootFsOptions = {
          compression = "lz4";
          atime = "off";
        };
        mountpoint = cfg.mountPoint;
      };
    };
  };
in
{
  disko.devices = raidArray;
}
