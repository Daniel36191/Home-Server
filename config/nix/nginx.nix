{ 
  pkgs,
  ...
}:
let
  addr = "lillypond.local";
  # domain = "portainer"; port = "9443"; secure = false
  # domain = "home"; port = "54321"; secure = false
  # domain = "proxmox"; port = "8006"; secure = true
  # domain = "crafty"; port = "8443"; secure = true

  mkCert = domain: pkgs.runCommand "cert-${domain}" { 
    nativeBuildInputs = [ pkgs.mkcert ];
  } ''
    HOME=$TMPDIR
    mkcert -cert-file cert.pem -key-file key.pem "${domain}.${addr}"
    mkdir -p $out
    cp cert.pem key.pem $out/
  '';
in
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    # other Nginx options
    virtualHosts = let domain = "portainer"; in {
      "${domain}.${addr}" =  {
        # enableACME = true;
        forceSSL = true;
        sslCertificate = "${mkCert domain}/cert.pem";
        sslCertificateKey = "${mkCert domain}/key.pem";
        locations."/" = {
          proxyPass = "https://127.0.0.1:9443";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;" +
            # required when the server wants to use HTTP Authentication
            "proxy_pass_header Authorization;"
            ;
        };
      };
    };
  };
}