{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  mod = config.modules.wireguard;
  vpsIp = "157.151.228.145";
  vpsPubKey = "dlrSwo6EPYkrOSJUrVA/zzG7XO9UqXkydfIi0nyhKAw=";
  ip = "${pkgs.iproute2}/bin/ip";
in
{
  config = mkIf mod.enable {
    networking.wireguard.interfaces.wg0 = {
      ips = [ "10.10.28.2/24" ];
      privateKeyFile = config.age.secrets."wg-home-private".path;
      allowedIPsAsRoutes = false;
      postSetup = ''
        ${ip} route add default dev wg0 table 100
        ${ip} rule add from 10.10.28.2 table 100 priority 100
      '';
      postShutdown = ''
        ${ip} rule del from 10.10.28.2 table 100 priority 100 || true
        ${ip} route flush table 100 || true
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
