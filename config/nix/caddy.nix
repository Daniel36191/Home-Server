{ 
  lib,
  services,
  vars,
  email,
  ...
}:
let
  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: cfg.domain or null != null) (lib.filterAttrs (_: cfg: cfg.enable or false) services.modules);

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs'
    (name: cfg: {
      name = "${if cfg.public or false then "${cfg.domain}.${vars.sld}.${vars.tld}" else "${cfg.domain}.${vars.sld}.local"}";
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
    email = email;

    virtualHosts = vhosts;
  };

  # systemd.tmpfiles.rules = [
  #   "d ${dir} 0775 ${config.services.caddy.user} services -"
  #   "d ${config.services.caddy.dataDir} 0775 ${config.services.caddy.user} services -"
  #   "d ${config.services.caddy.logDir} 0775 ${config.services.caddy.user} services -"
  # ];
}
