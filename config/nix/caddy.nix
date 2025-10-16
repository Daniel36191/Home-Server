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
    extraConfig =
      let
        # protocall = if cfg.secure then "https" else "http";
        protocall = "https";
      in ''
      reverse_proxy ${protocall}://localhost:${cfg.port}
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