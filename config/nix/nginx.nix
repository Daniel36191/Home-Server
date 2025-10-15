{ 
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    { domain = "portainer.${addr}"; port = "9443"; secure = true; }
    { domain = "home.${addr}"; port = "54321"; secure = false; default = true; }
    { domain = "proxmox.${addr}"; port = "8006"; secure = true; }
  ];

  makeVhost = cfg: {
    default = cfg.default or false;
    locations."/" = {
      proxyPass = "${if cfg.secure == true then "https" else "http" }://${addr}:${cfg.port}/";
      proxyWebsockets = true;
      forceSSL = cfg.secure;
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