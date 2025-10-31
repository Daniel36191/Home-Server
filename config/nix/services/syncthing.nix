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
    script = ''
      ${pkgs.syncthing}/bin/syncthing
      syncthing cli config gui raw-address set 0.0.0.0:8384
    '';
    serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
    };
  };
}