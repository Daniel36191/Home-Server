{
  lib,
  fun,
  ...
}:
with lib;
{
  options = {
    host = {
      username = mkOption { default = host; };
      sshPublicKey = mkOption { default = ""; };
      localIpAddress = mkOption { default = "127.0.0.1"; };
    };

    modules = { } // fun.generateModuleOptions;
  };
}
