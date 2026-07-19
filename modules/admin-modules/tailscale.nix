{
  config,
  lib,
  host,
  ...
}:
with lib;
let
  mod = config.modules.tailscale;
in
{
  config = mkIf mod.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "both";
      extraUpFlags = [
        "--advertise-exit-node"
        # "--accept-routes"
        # "--auth-key=file:${config.age.secrets."tailscale-${nix-host}".path}"
        "--reset"
      ];
      authKeyFile = config.age.secrets."tailscale-user-${host}".path;
    };

    # CRITICAL: Enable IP forwarding for exit node
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };
}
