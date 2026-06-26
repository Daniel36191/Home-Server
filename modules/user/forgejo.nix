{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
with lib;
let
  mod = config.modules.forgejo;
in
{
  options.modules.forgejo = {
    authentikClientId = mkOption {
      default = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };
  };

  config = mkIf mod.enable {
    services.forgejo = {
      enable = true;
      database.type = "mysql";
      lfs.enable = true;
      stateDir = mod.data-directory;

      settings = {
        server = {
          DOMAIN = with vars; "${mod.domain}.${sld}.${tld}";
          ROOT_URL = "https://${mod.domain}.${vars.sld}.${vars.tld}/";
          PROTOCALL = "https";
          HTTP_PORT = mod.port;

          START_SSH_SERVER = true;
          SSH_PORT = 2222;
          SSH_LISTEN_PORT = 2222;
        };
        service = {
          DISABLE_REGISTRATION = true;
          ENABLE_INTERNAL_SIGNIN = false;
          ENABLE_BASIC_AUTHENTICATION = false;
        };
        oauth2.ENABLED = true;
        oauth2_client = {
          ENABLE_AUTO_REGISTRATION = true;
          REGISTER_EMAIL_CONFIRM = false;
          USERNAME = "email";
          UPDATE_AVATAR = true;
          ACCOUNT_LINKING = "auto";
        };
        mailer.ENABLED = false;
      };
    };

    # Register the Authentik OAuth2
    systemd.services.forgejo.postStart = let
      forgejo-cli = "${config.services.forgejo.package}/bin/forgejo";
      cfg = config.services.forgejo;
      discoveryUrl = "https://${config.modules.authentik.domain}.${vars.sld}.${vars.tld}/application/o/forgejo/.well-known/openid-configuration";
    in ''
      if ! ${forgejo-cli} admin auth list --config ${cfg.customDir}/conf/app.ini \
            | grep -q "Authentik"; then
        ${forgejo-cli} admin auth add-oauth \
          --config ${cfg.customDir}/conf/app.ini \
          --name "Authentik" \
          --provider openidConnect \
          --key "${mod.authentikClientId}" \
          --secret "$(cat ${config.age.secrets."authentikClientSecret".path})" \
          --auto-discover-url "${discoveryUrl}" \
          --scopes "openid profile email" \
          --icon-url "https://goauthentik.io/img/icon.png"
      fi
    '';
  };
}