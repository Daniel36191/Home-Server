{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.kasmweb;
in
{
  options.modules.kasmweb.settings = {

  };
  config = mkIf mod.enable {
    services.kasmweb = {
      enable = true;
      listenPort = mod.proxy.port;
      datastorePath = mod.data.dataDirectory;
    };
  };
}
