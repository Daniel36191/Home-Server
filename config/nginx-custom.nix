{
  "auth" = {
    locations."/" = {
      proxyWebsockets = false;
      extraConfig = ''
        proxy_ssl_server_name on;
        proxy_pass_header Authorization;
        add_header Access-Control-Allow-Origin *;
      '';
    };
    default = false;
    forceSSL = true;
    sslCertificate = "/something/spome/auth.pem";
    useACMEHost = true;
  };
}