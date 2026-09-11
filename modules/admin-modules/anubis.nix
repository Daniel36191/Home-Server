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
    services.anubis =
      let
        enabledAnubis = lib.filterAttrs (
          name: cfg: (cfg.enable or false) && (cfg.proxy.anubis)
        ) config.modules;

        instances = lib.mapAttrs' (
          name: attrs:
          let
            cfg = attrs.proxy;
            protocol = if cfg.secure then "https" else "http";
          in
          {
            name = name;
            value = {
              enable = true;
              settings = {
                TARGET = "${protocol}://127.0.0.1:${toString cfg.port}";
                BIND_NETWORK = "unix"; # unix or tcp
                BIND = "/run/anubis/anubis-${name}/anubis.sock";
                JWT_RESTRICTION_HEADER = "CF-Connecting-IP";
                DIFFICULTY = 4;
              };
            };
          }
        ) enabledAnubis;
      in
      {
        instances = instances;
      };
    users.users.caddy = {
      extraGroups = [ "anubis" ];
    };
  };
}
