{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.fail2ban;

  enabledFail2ban = lib.filterAttrs (
    name: cfg: (cfg.enable or false) && (cfg.fail2ban.enable)
  ) config.modules;
in
{
  options.modules.fail2ban.settings = {

  };
  config = mkIf mod.enable {

    environment.etc =
      let
        instancesConf = lib.mapAttrs' (
          name: attrs:
          let
            cfg = attrs.fail2ban;
          in
          {
            name = "fail2ban/filter.d/${name}-probe.conf";
            value = {
              text = ''
                [Definition]
                failregex = ${cfg.matchRegx}
                ignoreregex =
              '';
            };
          }
        ) enabledFail2ban;

      in
      instancesConf;

    services.fail2ban =
      let
        instancesBan = lib.mapAttrs' (
          name: attrs:
          let
            cfg = attrs.fail2ban;
          in
          {
            name = name;
            value = {
              settings = {
                enabled = true;
                backend = "auto";
                filter = "${name}-probe";
                logpath = cfg.logFile;
                maxretry = 2;
                findtime = "30m";
                bantime = "5h";
                action = "iptables-allports";
              };
            };
          }
        ) enabledFail2ban;
      in
      {
        enable = true;
        jails = instancesBan;
      };
  };
}
