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
        enable = if config.services.caddy.enable then false else true;
        host = "${mod.proxy.domain}.${vars.sld}.${if mod.proxy.public then vars.tld else "local" }";
      };
      settings = {
        disable_startup_analytics = true;
        avatars = "initials";
        listen = {
          http = "0.0.0.0:3080";
          https = "0.0.0.0:${toString mod.proxy.port}";
        };
      };
    };
  };
}
