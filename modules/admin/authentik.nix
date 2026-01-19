{
  config,
  lib,
  vars,
  ...
}:
with lib;
let
  mod = config.modules.authentik;
in
{  
  config = mkIf mod.enable {
    services.authentik = {
      enable = true;
      environmentFile = config.age.secrets."authentik-env".path;
      nginx = {
        enable = true;
        host = "${mod.domain}.${vars.sld}.${if mod.public then vars.tld else "local" }";
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
  };
}
