{
  config,
  lib,
  ...
}:
with lib;
let
  sftpServer = "ssh://daniel@pc.local:22";
  archiveFolder = /media/archive;

  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false)
  ) config.modules;

  ## Create vhosts from enabled services
  backups = lib.mapAttrs'
    (name: cfg: {
      name = cfg.name;
      value = {
        paths = config.services.immich.mediaLocation;
        repo = "${sftpServer}${toString archiveFolder}";
        exclude = "${cfg.exclude}";
        startAt = "Sat 04:00";
        compression = "zstd";
        encryption.mode = "none";
        prune.keep = {
          last = 2;
        };
      };
    })
    enabledServices;
in
{
  services.borgbackup = {
    jobs = backups;
    jobs."Immich" = {
      paths = config.services.immich.mediaLocation;
      repo = "<path-to-borg-repo>";
      startAt = "Sat 04:00";
      compression = "zstd";
      encryption.mode = "none";
      prune.keep = {
        last = 2;
      };
    };
  };
}