{ 
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    { domain = "portainer.${addr}"; port = "9443"; protocall = "https"; }
    { domain = "home.${addr}"; port = "54321"; protocall = "http"; default = true; }
    { domain = "proxmox.${addr}"; port = "8006"; protocall = "https"; }
  ];

  makeVhost = cfg: {
    default = cfg.default or false;
    locations."/" = {
      proxyPass = "${cfg.protocall}://${addr}:${cfg.port}/";
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