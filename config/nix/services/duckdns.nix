{
  config,
  services,
  ...
}:
let
  mod = services.duckdns;
in
{
  services.duckdns = {
    enable = true;

    domains = mod.domains;

    tokenFile = config.age.secrets."duckdns-token".path;
  };
}