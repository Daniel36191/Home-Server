{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
with lib;
let
  mod = config.modules.caddy;
in
{
  config = mkIf mod.enable {
    services.caddy =
      let
        enabledServices = lib.filterAttrs (
          name: cfg: (cfg.enable or false) && (cfg.proxy.enable)
        ) config.modules;

        vhosts = lib.mapAttrs' (
          name: attrs:
          let
            cfg = attrs.proxy;
            uri = "${cfg.domain}.${vars.sld}";

            ## Pointer
            out-socket = "unix//run/anubis/anubis-${name}/anubis.sock";
            out-port = "127.0.0.1:${toString cfg.port}";
            destination = if cfg.anubis then out-socket else out-port;

            useHttps = if cfg.anubis then false else cfg.secure;

            ## Parts
            defaults = ''
              encode gzip zstd
              log {
                output file /var/log/caddy/access.log {
                  mode 0644
                }
              }
            '';
            ## This is broken now
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

            ## Header Parts
            header-defaults = ''
              header_up X-Real-IP {client_ip}
            '';

            header-public = ''
              header_up X-Forwarded-Proto https
              header_up Origin "https://{host}"
            '';

            header-secure = ''
              transport http {
                tls
                tls_insecure_skip_verify
              }
            '';

            robotsTxt = pkgs.writeTextDir "robots.txt" ''
              User-agent: *
              Disallow: /
            '';

            handle-robots = ''
              handle /robots.txt {
                root * ${robotsTxt}
                file_server
              }
            '';

          in
          {
            name = "${if cfg.public then "${uri}.${vars.tld}" else "${uri}.local"}";
            value = {
              extraConfig = ''
                ${defaults}
                ${handle-robots}
                ${if cfg.authentikAuth then authentikForwardAuth else ""}
                reverse_proxy ${destination} {
                  ${header-defaults}
                  ${if cfg.public then header-public else ""}
                  ${if useHttps then header-secure else ""}
                }
              '';
            };
          }
        ) enabledServices;
      in
      {
        enable = true;
        email = vars.email;
        virtualHosts = vhosts;
      };
  };
}
