{
  config,
  services,
  ...
}:
let
  mod = services.authentik;
in
{
  services.authentik = {
    enable = true;
    environmentFile = config.age.secrets."authentik-env".path;
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
      listen = {
        http = "0.0.0.0:3080";
        https = "0.0.0.0:${mod.port}";
      };
    };
  };
}