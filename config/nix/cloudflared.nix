{
  lib,
  config,
  vars,
  ... 
}:
let
  ## Do Catchal
  mode = true;


  ## Filter
  enabledServices = lib.filterAttrs (_: cfg: 
    cfg.enable or false && 
    cfg.public or false && 
    cfg.domain or null != null
  ) config.modules;

  ## Create Rules
  ingress = lib.mapAttrs' (name: cfg: {
    name = "${cfg.domain}.${vars.sld}.${vars.tld}";
    value = "${if cfg.secure or false then "https" else "http"}://127.0.0.1:${toString cfg.port}";
  }) enabledServices;
in
{
  options.modules.cloudflared = {
    services = lib.mkOption { default = ingress; };
};

  config = {
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
          "*.${vars.sld}.${vars.tld}" = "http://localhost:80";
        };
      };
    };
  };
}