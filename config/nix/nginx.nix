{ 
  ...
}:
let
  redirectConfig = [
    { domain = "home.lillypond.local"; port = "500"; }
    { domain = "portainer.lillypond.local"; port = "9443"; }
    { domain = "proxmox.lillypond.local"; port = "8006"; }
  ];

  makeVhost = cfg: {
    serverName = cfg.domain;
    locations."/" = {
      # Redirect to the same protocol but different port
      return = "301 $scheme://lillypond.local:${cfg.port}$request_uri";
    };
    
    # Add this to handle HTTPS requests properly
    listen = [
      {
        addr = "0.0.0.0";
        port = 80;
      }
      {
        addr = "0.0.0.0";
        port = 443;
        ssl = true;
      }
    ];
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