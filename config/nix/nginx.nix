{ 
  pkgs,
  lib,
  services,
  ...
}:
let
  addr = "lillypond.local";

  mkCert = domain: pkgs.runCommand "cert-${domain}" {
    nativeBuildInputs = [ pkgs.mkcert ];
  } ''
    HOME=$TMPDIR
    mkcert -cert-file cert.pem -key-file key.pem "${domain}.${addr}"
    mkdir -p $out
    cp cert.pem key.pem $out/
  '';
  vhosts = lib.mapAttrs'
    (name: cfg:
      lib.optionalAttrs (cfg.enable or false) {
        name = "${cfg.domain or name}.${addr}";
        value = {
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
          sslCertificate = "${mkCert (cfg.domain or name)}/cert.pem";
          sslCertificateKey = "${mkCert (cfg.domain or name)}/key.pem";
        });
      }
    )
    services;
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
