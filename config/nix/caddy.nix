{ 
  lib,
  config,
  vars,
  ...
}:
let
  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && 
    (cfg.url or false)
  ) config.modules;

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${if cfg.public or false then "${cfg.domain}.${vars.sld}.${vars.tld}" else "${cfg.domain}.${vars.sld}.local"}";
      value = {
        extraConfig = ''
          encode gzip zstd
          reverse_proxy ${if cfg.secure then "https" else "http"}://127.0.0.1:${toString cfg.port}{
            X-Forwarded-Proto {scheme}
          }
        '';
      };
    })
    enabledServices;

in {
  services.caddy = {
    enable = true;
    email = vars.email;

    virtualHosts = vhosts;
  };
}
