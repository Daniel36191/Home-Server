{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.otterwiki;
in
{  
  options.modules.otterwiki = {

  };
  config = mkIf mod.enable {
    environment.systemPackages = with pkgs-otterwiki; {
      otterwiki
    };
    services.otterwiki = {
      enable = true;
      instances."testing" = {
        socket = {
          type = "tcp";
          address = "0.0.0.0:${mod.port}";
        };
      };
    };
  };
}
