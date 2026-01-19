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
      tunnels."af01604f-361d-4f2f-8a94-b6d2de47cb90" = {
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