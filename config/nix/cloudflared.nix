{
  lib,
  config,
  vars,
  ... 
}:

## WARN: Doesn't create dns CNAME record for "*.SLD.TLD"

let
  id = "43387887-077c-4587-8be7-58fcc0f35558";
in
{
  config = {
    services.cloudflared = {
      enable = true;
      certificateFile = config.age.secrets."cloudflared-token".path;
      tunnels."${id}" = {
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