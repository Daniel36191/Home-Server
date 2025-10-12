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
    enableACME = true;  # Automatically get SSL certificates
    forceSSL = true;    # Force HTTPS
    locations."/" = {
      return = "301 https://lillypond.local:${cfg.port}$request_uri";
    };
  };

  vhosts = map makeVhost redirectConfig;
in
{
  services.nginx = {
    enable = true;
    virtualHosts = builtins.listToAttrs (map (vhost: {
      name = vhost.serverName;
      value = vhost;
    }) vhosts);
  };
  
  # Enable ACME for Let's Encrypt certificates
  security.acme = {
    acceptTerms = true;
    defaults.email = "your-email@example.com";
  };
}