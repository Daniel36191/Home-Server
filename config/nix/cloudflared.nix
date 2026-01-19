{
  lib,
  config,
  vars,
  ... 
}:
let
  id = "43387887-077c-4587-8be7-58fcc0f35558";

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
      tunnels."${id}" = {
        credentialsFile = config.age.secrets."cloudflared-creds".path;
        default = "http_status:404";
        originRequest = {
          noTLSVerify = true;
        };
        ingress = ingress;
      };
    };
  };
}