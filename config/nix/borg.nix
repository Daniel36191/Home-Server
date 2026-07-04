{
  config,
  lib,
  ...
}:
with lib;
let
  sftpServer = "ssh://daniel@pc.local:22";
  archiveFolder = "/media/archive";

  enabledServices = lib.filterAttrs (
    _: cfg: (cfg.enable or false) && (cfg.backups.enable or false)
  ) config.modules;

  allPaths = lib.flatten (lib.mapAttrsToList (_: cfg: cfg.backups.include) enabledServices);
  allExcludes = lib.flatten (lib.mapAttrsToList (_: cfg: cfg.backups.exclude) enabledServices);
in
{
  services.borgbackup.jobs."homelab" = {
    paths = allPaths;
    exclude = allExcludes;
    repo = "${sftpServer}${archiveFolder}/";
    startAt = "Mon 08:00";
    compression = "zstd";
    encryption.mode = "none";
    prune.keep = {
      last = 2;
    };
  };
}
