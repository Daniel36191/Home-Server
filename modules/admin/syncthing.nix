{
    pkgs,
    config,
    lib,
    ...
}:
with lib;
let
  mod = config.modules.syncthing;
in
{
  config = mkIf mod.enable {
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
          syncthing cli config gui raw-address set 0.0.0.0:${builtins.toString mod.port}
          '';
          Restart = "on-failure";
      };
    };
  };
}