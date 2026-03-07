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
    (cfg.proxy.enable or false)
  ) config.modules;

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${if cfg.proxy.public or false then "http://${cfg.proxy.domain}.${vars.sld}.${vars.tld}" else "${cfg.proxy.domain}.${vars.sld}.local"}";
      value = {
        extraConfig = ''
          encode gzip zstd
          log {
            output file /var/log/caddy/access.log {
              mode 0644
            }
          }
          reverse_proxy 127.0.0.1:${toString cfg.proxy.port}{
            transport http {
            ${if cfg.proxy.secure then ''
              tls
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

    # virtualHosts = lib.mergeAttrs vhosts config.extra-proxy.caddy;
    virtualHosts = vhosts;
  };
}
