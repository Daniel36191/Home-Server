{
  config,
  lib,
  vars,
  ...
}:
with lib;
let
  mod = config.modules.forgejo;
in
{  
  options.modules.forgejo = {

  };
  config = mkIf mod.enable {
    services.forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      stateDir = mod.data-directory
      settings = {
        server = {
          DOMAIN = with vars; "forgejo.${sld}.${tld}";
          # You need to specify this to remove the port from URLs in the web UI.
          ROOT_URL = "https://${srv.DOMAIN}/"; 
          HTTP_PORT = mod.port;
        };
        # You can temporarily allow registration to create an admin user.
        service.DISABLE_REGISTRATION = true; 
        # Add support for actions, based on act: https://github.com/nektos/act
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };
        # Sending emails is completely optional
        # You can send a test email from the web UI at:
        # Profile Picture > Site Administration > Configuration >  Mailer Configuration 
        mailer = {
          ENABLED = false;
          # SMTP_ADDR = "mail.example.com";
          # FROM = "noreply@${srv.DOMAIN}";
          # USER = "noreply@${srv.DOMAIN}";
        };
      };
    };
  };
}
