{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.caldav;
in
{
  config = mkIf mod.enable {
    services.radicale = {
      enable = true;
      settings = {
        server = {
          hosts = [ "0.0.0.0:5232" "[::]:5232" ];
          max_connections = 20;
          timeout = 30;
          max_content_length = 100000000;
        };
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.age.secrets."caldav-creds".path;
          htpasswd_encryption = "bcrypt";
          delay = 1;
        };
        storage = {
          filesystem_folder = mod.data-directory;
        };
      };
      rights = {
      };
    };
  };
}