{
  config,
  services,
  local-address,
  ...
}:
let
  mod = services.authentik;
in
{
  services.authentik = {
    enable = true;
    environmentFile = config.age.secrets."authentik-env".path;
    nginx = {
      enable = true;
      host = "${mod.domain}.${local-address}";
    };
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
      listen = {
        http = "0.0.0.0:3080";
        https = "0.0.0.0:${toString mod.port}";
      };
    };
  };
}
