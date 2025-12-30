{
    pkgs,
    services,
    ...
}:
{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  systemd.user.services.syncthing = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "File sync service";
    serviceConfig = {
        Type = "simple";
        ExecStart = ''
        ${pkgs.syncthing}/bin/syncthing
        syncthing cli config gui raw-address set 0.0.0.0:${services.syncthing.port}
        '';
        Restart = "on-failure";
    };
  };
}