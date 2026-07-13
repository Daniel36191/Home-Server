{
  lib,
  ...
}:
with lib;
{
  options.host = {
    sshPublicKey = mkOption { default = ""; };
    localIpAddress = mkOption { default = "127.0.0.1"; };
  };
}
