{
  lib,
  config,
  vars,
  services,
  ... 
}:
let
  ## Do CatchAll
  mode = true;


  ## Filter
  enabledServices = lib.filterAttrs (_: cfg: 
    cfg.enable or false && 
    cfg.public or false && 
    cfg.domain or null != null
  ) services.modules;

  ## Create Rules
  ingress = lib.mapAttrsToList (name: cfg: {
    hostname = "${cfg.domain}.${vars.sld}.${vars.tld}";
    service = "${if cfg.secure or false then "https" else "http"}://127.0.0.1:${toString cfg.port}";
  }) enabledServices;
in
{
  services.cloudflared = {
    enable = true;
    certificateFile = config.age.secrets."cloudflared-token".path;
    tunnels."c8729276-c5da-4ca9-a170-a1535782266a" = {
      credentialsFile = config.age.secrets."cloudflared-creds".path;
      default = "http_status:404";
      originRequest = {
        noTLSVerify = true;
      };
      ingress = if !mode then ingress else {
        "*.${vars.sld}.${vars.tld}" = "https://localhost:80";
      };
    };
  };
}