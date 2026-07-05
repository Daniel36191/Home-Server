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
  cfg = config.services.forgejo;
in
{
  options.modules.forgejo.settings = {
    authentikClientId = mkOption {
      default = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };
    sshPort = mkOption {
      default = 2222;
    };
    runnerEnable = mkOption {
      default = false;
    };
    runnerLabels = mkOption {
      default = [ "native:host" ];
    };
    forgeSync = mkOption {
      default = false;
    };
  };

  config = mkIf mod.enable {
    services.forgejo = {
      enable = true;
      database.type = "sqlite3";
      lfs.enable = true;
      stateDir = mod.data.data-directory;

      settings = {
        server = {
          DOMAIN = with vars; "${mod.proxy.domain}.${sld}.${tld}";
          ROOT_URL = "${cfg.settings.server.PROTOCAL}://${mod.proxy.domain}.${vars.sld}.${vars.tld}/";
          PROTOCAL = "https";
          HTTP_PORT = mod.proxy.port;

          START_SSH_SERVER = true;
          SSH_PORT = mod.settings.sshPort;
          SSH_LISTEN_PORT = mod.settings.sshPort;
          SSH_DOMAIN = with vars; "ssh.${sld}.${tld}";
        };
        service = {
          DISABLE_REGISTRATION = true;
          ENABLE_INTERNAL_SIGNIN = false;
          ENABLE_BASIC_AUTHENTICATION = false;
        };
        actions.ENABLED = mod.settings.runnerEnable;
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

    services.gitea-actions-runner = mkIf mod.settings.runnerEnable {
      package = pkgs.forgejo-runner;
      instances.default = {
        enable = true;
        name = "forgejo-runner";
        url = "${cfg.settings.server.PROTOCAL}://${mod.proxy.domain}.${vars.sld}.${vars.tld}";
        tokenFile = config.age.secrets.forgejo-runner-token.path;
        labels = mod.settings.runnerLabels;
      };
    };

    # Register the Authentik OAuth2
    systemd.services.forgejo.postStart =
      let
        forgejo-cli = "${cfg.package}/bin/forgejo";
        discoveryUrl = "${cfg.settings.server.PROTOCAL}://${config.modules.authentik.proxy.domain}.${vars.sld}.${vars.tld}/application/o/forgejo/.well-known/openid-configuration";
      in
      ''
        if ! ${forgejo-cli} admin auth list --config ${cfg.customDir}/conf/app.ini \
              | grep -q "Authentik"; then
          ${forgejo-cli} admin auth add-oauth \
            --config ${cfg.customDir}/conf/app.ini \
            --name "Authentik" \
            --provider openidConnect \
            --key "${mod.settings.authentikClientId}" \
            --secret "$(cat ${config.age.secrets."authentikClientSecret".path})" \
            --auto-discover-url "${discoveryUrl}" \
            --scopes "openid profile email" \
            --icon-url "https://goauthentik.io/img/icon.png"
        fi
      '';

    services.forgesync = mkIf mod.settings.forgeSync {
      enable = true;
      jobs = {
        github = {
          source = cfg.settings.server.ROOT_URL;
          target = "github";
          settings = {
            remirror = true;
            description-template = "{description} (Mirror of {url})";
            feature = [
              "issues"
              "pull-requests"
            ];
            on-commit = true;
            mirror-interval = "24h0m0s";
          };
          secretFile = config.age.secrets.forgesync.path;
          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
          };
        };
      };
    };
  };
}
