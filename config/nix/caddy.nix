{ 
  lib,
  config,
  vars,
  ...
}:
let
  enabledServices = lib.filterAttrs (_: cfg: 
    (cfg.enable or false) && 
    (cfg.url or false)
  ) config.modules;

  authentikForwardAuth = ''
    forward_auth https://auth.${vars.sld}.${vars.tld} {
      uri /outpost.goauthentik.io/auth/caddy
      copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Entitlements \
                  X-Authentik-Email X-Authentik-Name X-Authentik-Uid \
                  X-Authentik-Jwt X-Authentik-Meta-Jwks \
                  X-Authentik-Meta-Outpost X-Authentik-Meta-Provider \
                  X-Authentik-Meta-App X-Authentik-Meta-Version
    }
  '';

  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${if cfg.public or false 
        then "http://${cfg.domain}.${vars.sld}.${vars.tld}" 
        else "${cfg.domain}.${vars.sld}.local"}";
      value = {
        extraConfig = ''
          encode gzip zstd
          log {
            output file /var/log/caddy/access.log {
              mode 0644
            }
          }
          ${if cfg.authentik-auth or false then authentikForwardAuth else ""}
          reverse_proxy 127.0.0.1:${toString cfg.port} {
            header_up CF-Connecting-IP {header.CF-Connecting-IP}
            ${if cfg.public or false then ''
              header_up X-Forwarded-Proto https
              header_up Origin "https://{host}"
            '' else ""}
            ${if cfg.public or false 
              then "header_up X-Forwarded-Proto https" 
                else ""}
            ${if cfg.secure or false then ''
            transport http {
              tls
              tls_insecure_skip_verify
            }
            '' else ""}
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