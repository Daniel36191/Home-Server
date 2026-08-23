{
  lib,
  fun,
  ...
}:
with lib;
{
  options = {
    host = {
      sshPublicKey = mkOption { default = ""; };
      hostId = mkOption { default = ""; };
      localIpAddress = mkOption { default = "127.0.0.1"; };
    };

    modules = { } // fun.generateModuleOptions;
  };
}
