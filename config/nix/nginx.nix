{ 
  ...
}:
let
  redirectConfig = [
    { domain = "home.lillypond.local"; port = "500"; }
    { domain = "proxmox.lillypond.local"; port = "8006"; }
  ];

  makeVhost = cfg: {
    serverName = cfg.domain;
    locations."/" = {
      return = "301 $scheme://lillypond.local:${cfg.port}$request_uri";
    };
  };

  vhosts = map makeVhost redirectConfig;
in {
  services.nginx = {
    enable = true;
    virtualHosts = builtins.listToAttrs (map (vhost: {
      name = vhost.serverName;
      value = vhost;
    }) vhosts);
  };
}