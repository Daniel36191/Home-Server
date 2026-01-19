{ 
  pkgs,
  lib,
  config,
  vars,
  ...
}:
let

  ## Filter enabled services
  enabledServices = lib.filterAttrs (_: cfg: cfg.domain or null != null) (lib.filterAttrs (_: cfg: cfg.enable or false) config.modules);

  mkCert = domain: pkgs.runCommand "cert-${domain}" {
    nativeBuildInputs = [ pkgs.mkcert ];
  } ''
    HOME=$TMPDIR
    mkcert -cert-file cert.pem -key-file key.pem "${domain}.${vars.sld}.${vars.tld}"
    mkdir -p $out
    cp cert.pem key.pem $out/
  '';

  ## Create vhosts from enabled services
  vhosts = lib.mapAttrs
    (name: cfg: {
      name = "${cfg.domain}.${vars.sld}.${vars.tld}";
      value = {
        default = lib.mkDefault cfg.default or false;
        locations."/" = {
          proxyPass = lib.mkForce "${if cfg.secure then "https" else "http"}://:${toString cfg.port}/";
          proxyWebsockets = lib.mkDefault true;
          extraConfig = lib.mkDefault ''
            proxy_ssl_server_name on;
            proxy_pass_header Authorization;
            add_header Access-Control-Allow-Origin *;
          '';
        };
        forceSSL = lib.mkDefault true;
        useACMEHost = lib.mkDefault true;
        sslCertificate = "${mkCert cfg.domain}/cert.pem";
        sslCertificateKey = "${mkCert cfg.domain}/key.pem";
      };
    })
    enabledServices;

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
