{ 
  lib,
  config,
  services,
  address,
  email,
  ...
}:
let
  dir = "/services/caddy";

  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: cfg.domain or null != null) (lib.filterAttrs (_: cfg: cfg.enable or false) services);

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${cfg.domain}.${address}";
      value = {
        extraConfig = ''
        encode gzip zstd
        reverse_proxy ${if cfg.secure then "https" else "http"}://127.0.0.1:${toString cfg.port}
        '';
      };
    })
    enabledServices;

in {
  services.caddy = {
    enable = true;
    user = "caddy";
    group = "services";
    email = email;
    # dataDir = "${dir}/data
    # logDir = "${dir}/logs";

    virtualHosts = vhosts;
  };

  # systemd.tmpfiles.rules = [
  #   "d ${dir} 0775 ${config.services.caddy.user} services -"
  #   "d ${config.services.caddy.dataDir} 0775 ${config.services.caddy.user} services -"
  #   "d ${config.services.caddy.logDir} 0775 ${config.services.caddy.user} services -"
  # ];
}
