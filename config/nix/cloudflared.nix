{
  lib,
  config,
  address,
  services,
  ...
}:
let
    ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: cfg.domain or null != null) (lib.filterAttrs (_: cfg: cfg.enable or false) services);

  ## Create vhosts from enabled services
  ingress-hosts = lib.mapAttrs'
    (name: cfg: {
      name = "${cfg.domain}.${address}";
      value = "${if cfg.secure then "https" else "http"}://127.0.0.1:${toString cfg.port}";
    })
    enabledServices;
in
{
  servicses.cloudflared = {
    enable = true;
    certificateFile = config.age.secrets."cloudflared-token".path;

    tunnels."c8729276-c5da-4ca9-a170-a1535782266a" = {
      credentialsFile = config.age.secrets."cloudflared-creds".path;
      default = "http_status:404";
      ingress = ingress-hosts;
    };
  };
}