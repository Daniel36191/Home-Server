{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.opencloud;
in
{  
  options.modules.opencloud = {

  };
  config = mkIf mod.enable {

    services.opencloud = {
      enable = true;
      group = "services";
      user = mod.owner;
      port = mod.port;
      stateDir = mod.data-directory;
      address = "0.0.0.0";
    };

  };
}
