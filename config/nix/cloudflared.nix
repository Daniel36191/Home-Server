{
  lib,
  config,
  vars,
  ... 
}:
let
  ## "catchAll", "auto", "manual"
  mode = "manual";


  ## Filter
  enabledServices = lib.filterAttrs (_: cfg: 
    cfg.enable or false && 
    cfg.public or false && 
    cfg.domain or null != null
  ) config.modules;

  ## Create Rules
  ingress = lib.mapAttrs' (name: cfg: {
    name = "${cfg.domain}.${vars.sld}.${vars.tld}";
    value = "${if cfg.secure or false then "http" else "https"}://localhost:${toString cfg.port}";
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
      tunnels."0bd0c551-d1bd-483c-bcb9-65180e17bb82" = {
        credentialsFile = config.age.secrets."cloudflared-creds".path;
        default = "http_status:404";
        originRequest = {
          noTLSVerify = true;
        };
        ingress = if mode == "auto" then ingress else if mode == "catchAll" then {
          "*.${vars.sld}.${vars.tld}" = "http://localhost:80";
          "*.${vars.sld}.${vars.tld}" = "https://localhost:443";
          } else if mode == "manual" then { 
          "*.${vars.sld}.${vars.tld}" = "http://localhost:80"; 
          } else null;
      };
    };
  };
}