{ 
  ...
}:
{
  security.acme = {
  acceptTerms = true;
  email = "dmoeller38@outlook.com";
};

services.nginx = {
  enable = true;
  recommendedGzipSettings = true;
  recommendedOptimisation = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  virtualHosts."portainer.lillypond.local" = {
    default = true;
    enableACME = true;
    addSSL = true;
    locations."/" = {
      proxyPass = "https://lillypond.local:9443/";
    };
  };
};

}