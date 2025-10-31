{ 
  pkgs,
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    { domain = "portainer.${addr}"; port = "9443"; secure = false; }
    { domain = "home.${addr}"; port = "54321"; secure = false; default = true; }
    { domain = "proxmox.${addr}"; port = "8006"; secure = true; }
    { domain = "crafty.${addr}"; port = "8443"; secure = true; sockets = true; }
  ];

  mkCert = domain: pkgs.runCommand "cert-${domain}" { 
    nativeBuildInputs = [ pkgs.mkcert ];
    } ''
      HOME=$TMPDIR
      mkcert -cert-file cert.pem -key-file key.pem "${domain}.${addr}"
      mkdir -p $out
      cp cert.pem key.pem $out/
    '';
  makeVhost = cfg: {
    default = cfg.default or false;
    locations."/" = {
      proxyPass = "${if cfg.secure == true then "https" else "http" }://${addr}:${cfg.port}/";
      proxyWebsockets = cfg.sockets or false;
    };
    forceSSL = cfg.secure;
  } // (if cfg.secure then {
    sslCertificate = "${mkCert cfg.domain}/cert.pem";
    sslCertificateKey = "${mkCert cfg.domain}/key.pem";
    locations."/" = {
      extraConfig =
        # required when the target is also TLS server with multiple hosts
        "proxy_ssl_server_name on;" +
        # required when the server wants to use HTTP Authentication
        "proxy_pass_header Authorization;"
        ;
    };
  } else {});

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