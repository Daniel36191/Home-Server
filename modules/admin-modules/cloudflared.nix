{
  config,
  vars,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.cloudflared;
in
## WARN: Doesn't create routes via dash.cloudflare.com => Networking => Tunnels => Routes
{
  options.modules.cloudflared.settings = {
    id = mkOption { default = ""; };
  };

  config = mkIf mod.enable {
    services.cloudflared = {
      enable = true;
      certificateFile = config.age.secrets."cloudflared-token".path;
      tunnels."${mod.settings.id}" = {
        credentialsFile = config.age.secrets."cloudflared-creds".path;
        default = "http_status:404";
        originRequest = {
          noTLSVerify = true;
        };
        ingress = {
          "*.${vars.sld}.${vars.tld}" = "http://localhost";
        };
      };
    };
  };
}
