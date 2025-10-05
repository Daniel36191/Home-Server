{ 
  ...
}:
let
  redirectConfig = [
    { domain = "home.lillypond.local"; port = "500"; }
    { domain = "api.lillypond.local"; port = "3000"; }
    { domain = "app.lillypond.local"; port = "8080"; }
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