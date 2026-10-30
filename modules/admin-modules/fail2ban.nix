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
        ignoreIP =
          let
            wgConf = config.modules.wireguard;
            WgInterfaceIp = wgConf.settings.interfaceIp;
            octets = builtins.filter builtins.isString (builtins.split "\\." WgInterfaceIp);
            wgIp = with builtins; "${elemAt octets 0}.${elemAt octets 1}.${elemAt octets 2}.0";
          in
          [
            "127.0.0.0/8"
            "192.168.0.0/16"
          ]
          ++ lib.optional wgConf.enable or false "${wgIp}/24"
          ++ lib.optional wgConf.enable or false "${wgIp}/24";
      };
  };
}
