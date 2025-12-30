{ 
  pkgs,
  lib,
  ...
}:
let
  addr = "lillypond.local";
  proxyConfig = [
    ## Static
    { domain = "home"; port = "54321"; secure = false; default = true; }
    { domain = "portainer"; port = "9443"; secure = true; }

    ## Dynamic
    { domain = "proxmox"; port = "8006"; secure = true; }
    # { domain = "crafty"; port = "8443"; secure = true; sockets = true; }
    { domain = "syncthing"; port = "8384"; secure = false; sockets = true; }
    { domain = "files"; port = "3923"; secure = false; sockets = true; } ## CopyParty
    { domain = "kasm"; port = "3030"; secure = true; sockets = true; }
    { domain = "nextcloud"; port = "8443"; secure = true; sockets = true; }
    { domain = "jellyfin"; port = "8920"; secure = true; sockets = true; }

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
      proxyPass = "${if cfg.secure then "https" else "http"}://${addr}:${toString cfg.port}/";
      proxyWebsockets = cfg.sockets or false;
    } // (lib.optionalAttrs cfg.secure {
      extraConfig = ''
        proxy_ssl_server_name on;
        proxy_pass_header Authorization;
      '';
    });
    forceSSL = cfg.secure or false;
  } // (lib.optionalAttrs cfg.secure {
    sslCertificate = "${mkCert cfg.domain}/cert.pem";
    sslCertificateKey = "${mkCert cfg.domain}/key.pem";
  });

  vhosts = builtins.listToAttrs (map (cfg: {
    name = "${cfg.domain}.${addr}";
    value = makeVhost cfg;
  }) proxyConfig);
in {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    clientMaxBodySize = "1024m";
    virtualHosts = vhosts;
  };
} 