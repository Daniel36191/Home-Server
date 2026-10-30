{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.firewall;
  cfg = config.modules;

  servicesPorts = builtins.filter (x: x != 0) (map (n: cfg.${n}.proxy.port) (builtins.attrNames cfg));
in
{
  options.modules.firewall.settings = {
  };
  config = mkIf mod.enable {
    networking.firewall = {
      enable = true;
      ## If wireguard then check carried ip else default of true
      checkReversePath = if cfg.wireguard.enable or false then "loose" else true;
      interfaces."${cfg.wireguard.settings.interface}" = {
        allowedTCPPorts = [
          80
          443
        ]
        ++ servicesPorts;
        allowedUDPPorts = [
          443
        ]
        ++ servicesPorts;
      };
    };
  };
}
