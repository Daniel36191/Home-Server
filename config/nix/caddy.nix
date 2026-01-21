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
          reverse_proxy 127.0.0.1:${toString cfg.port}{
            transport http {
            ${if cfg.secure then ''
              tls self_signed
              tls_insecure_skip_verify
            '' else ""}
            }
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
