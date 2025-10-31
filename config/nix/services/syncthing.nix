{
    pkgs,
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
        script = ''
        ${pkgs.syncthing}/bin/syncthing
        syncthing cli config gui raw-address set 0.0.0.0:8384
        '';
        Restart = "on-failure";
    };
  };
}