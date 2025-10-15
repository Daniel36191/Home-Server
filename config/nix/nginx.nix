{ 
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    { domain = "portainer.${addr}"; port = "9443"; }
    { domain = "home.${addr}"; port = "54321"; /* default = true; */ } ## badgateway???
    { domain = "proxmox.${addr}"; port = "8006"; }
  ];

  makeVhost = cfg: {
    default = cfg.default or false;
    locations."/" = {
      proxyPass = "http://${addr}:${cfg.port}/";
      proxyWebsockets = true;
    };
  };

  vhosts = builtins.listToAttrs (map (cfg: {
    name = cfg.domain;
    value = makeVhost cfg;
  }) proxyConfig);
in {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = vhosts;
  };
}