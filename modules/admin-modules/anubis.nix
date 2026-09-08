{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.anubis;
in
{
  config = mkIf mod.enable {
    services.anubis = {
      instances."forgejo" = {
        enable = true;
        settings = {
          TARGET = "http://127.0.0.1:3000";
          BIND_NETWORK = "tcp";
          BIND = "127.0.0.1:8000";
          JWT_RESTRICTION_HEADER = "CF-Connecting-IP";
          DIFFICULTY = 4;
        };
      };
    };
  };
}
