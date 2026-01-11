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
    };
  };
}