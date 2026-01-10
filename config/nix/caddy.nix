{ 
  lib,
  services,
  address,
  ...
}:
let

  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: !cfg.no-proxy or false) (lib.filterAttrs (_: cfg: cfg.enable or false) services);

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${cfg.domain}.${address}";
      value = {
        extraConfig = ''
        encode gzip zstd
        reverse_proxy ${if cfg.secure then "https" else "http"}://${address}:${toString cfg.port}
        '';
      };
    })
    enabledServices;

in {
  services.caddy = {
    enable = true;
    dataDir = "/services/caddy/data";
    logDir = "/services/caddy/logs";

    virtualHosts = vhosts;
  };
}
