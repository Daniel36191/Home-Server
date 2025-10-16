{ 
  localipaddress,
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    { domain = "portainer.${addr}"; port = "9443"; secure = true; }
    { domain = "home.${addr}"; port = "54321"; secure = false; }
    { domain = "proxmox.${addr}"; port = "8006"; secure = true; }
  ];

  makeVhost = cfg: {
    extraConfig = ''
      reverse_proxy ${if cfg.secure == true then "https" else "http"}://localhost:${cfg.port}
    '';
  };

  vhosts = builtins.listToAttrs (map (cfg: {
    name = cfg.domain;
    value = makeVhost cfg;
  }) proxyConfig);
in {
  services.caddy = {
    enable = true;
    virtualHosts = vhosts;
  };
}