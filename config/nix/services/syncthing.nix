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
        ExecStart = "${pkgs.syncthing}/bin/syncthing";
        Restart = "on-failure";
    };
  };
}