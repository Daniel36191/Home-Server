{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  mod = config.modules.minecraft;

  rconPassword = config.age.secrets."minecraft-rcon".path;

  rconScript = pkgs.writeShellScriptBin "mc-rcon" ''
    ${pkgs.mcrcon}/bin/mcrcon \
      -P ${mod.settings.rconPort} \
      -p "$(cat ${rconPassword})" \
  '';
  permsScript = pkgs.writeShellScriptBin "mc-perms" ''
    	chown -R ${mod.data.owner}:services ${mod.data.dataDirectory}
  '';
in
{
  options.modules.minecraft.settings = {
    runArgs = mkOption {
      default = "chmod +x ./run.sh && ./run.sh";
    };
    javaPackage = mkOption {
      default = pkgs.javaPackages.compiler.temurin-bin.jre-17;
    };
    rconPort = mkOption {
      default = "25575";
    };
    autoStart = mkOption {
      default = false;
    };
    packName = mkOption {
      default = "Server";
    };
  };

  config = mkIf mod.enable {
    users.users.${mod.data.owner} = {
      isSystemUser = true;
      createHome = false;
      group = "services";
      home = mod.data.dataDirectory;
    };

    environment.systemPackages = [ rconScript ];
    system.activationScripts = {
      mc-rcon = ''
        ln -sf ${rconScript}/bin/mc-rcon ${mod.data.dataDirectory}/rcon.sh
      '';
      mcPerms = ''
        ln -sf ${permsScript}/bin/mc-perms ${mod.data.dataDirectory}/perms.sh
      '';
    };

    networking.firewall.allowedTCPPorts = [ mod.proxy.port ];

    systemd.services."minecraft-${mod.settings.packName}" = {
      enable = true;
      description = "Minecraft Server";
      after = [ "network.target" ];
      wantedBy = [ "default.target" ] ++ lib.optional mod.settings.autoStart "multi-user.target";

      serviceConfig = {
        User = mod.data.owner;
        Group = "services";
        WorkingDirectory = mod.data.dataDirectory;

        ExecStart = "${pkgs.bash}/bin/bash -c '${mod.settings.javaPackage}/bin/java ${mod.settings.runArgs}'";

        ExecStop = "${pkgs.mcrcon}/bin/mcrcon -P ${toString mod.settings.rconPort} -p $(cat ${rconPassword}) stop";

        TimeoutStopSec = "60s";
        KillMode = "mixed";

        ReadWritePaths = [ mod.data.dataDirectory ];
        NoNewPrivileges = true;

        Restart = if mod.settings.autoStart then "on-failure" else "no";
        RestartSec = "10s";
      };
    };
  };

}
