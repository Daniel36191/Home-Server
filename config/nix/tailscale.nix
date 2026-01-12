{
  config,
  nix-host,
  pkgs,
  ...
}:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--advertise-exit-node"
      "--exit-node-allow-lan-access"
      # "--accept-routes"
      # "--auth-key=file:${config.age.secrets."tailscale-${nix-host}".path}"
      "--reset"
    ];
    authKeyFile = config.age.secrets."tailscale-user-admin".path;
  };

  # CRITICAL: Enable IP forwarding for exit node
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

}
