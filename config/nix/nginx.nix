{ 
  ...
}:
let
  proxyConfig = [
    { domain = "portainer.lillypond.local"; port = "9443"; default = true; }
    { domain = "home.lillypond.local"; port = "500"; }
    { domain = "proxmox.lillypond.local"; port = "8006"; }
  ];

  makeVhost = cfg: {
    default = cfg.default or false;
    locations."/" = {
      proxyPass = "https://lillypond.local:${cfg.port}/";
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