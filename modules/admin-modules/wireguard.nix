{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  mod = config.modules.wireguard;

  ipPkg = "${pkgs.iproute2}/bin/ip";
in
{
  options.modules.wireguard.settings = {
    vpsIp = mkOption { default = ""; };
    vpsPubKey = mkOption { default = ""; };
    interfaceIp = mkOption { default = "10.10.28.2"; };
    interface = mkOption { default = "wg0"; };
  };
  config = mkIf mod.enable {
    networking.wireguard.interfaces."${interface}" = {
      ips = [ "${interfaceIp}/24" ];
      privateKeyFile = config.age.secrets."wg-home-private".path;
      allowedIPsAsRoutes = false;
      postSetup = ''
        ${ipPkg} route add default dev ${interface} table 100
        ${ipPkg} rule add from ${interfaceIp} table 100 priority 100
      '';
      postShutdown = ''
        ${ipPkg} rule del from ${interfaceIp} table 100 priority 100 || true
        ${ipPkg} route flush table 100 || true
      '';
      peers = [
        {
          publicKey = vpsPubKey;
          endpoint = "${vpsIp}:51820";
          allowedIPs = [ "0.0.0.0/0" ];
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
