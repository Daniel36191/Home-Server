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
      -P ${mod.rconPort} \
      -p "$(cat ${rconPassword})" \
  '';
in
{
  options.modules.minecraft = {
    runArgs = mkOption {
      default = ''chmod +x ./run.sh && ./run.sh'';
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

  config = {
    users.users.${mod.owner} = {
      isSystemUser = true;
      createHome = false;
      group = "services";
      home = mod.data-directory;
    };

    environment.systemPackages = [ rconScript ];
    system.activationScripts = {
      minecraft-rcon = ''
        ln -sf ${rconScript}/bin/mc-rcon ${mod.data-directory}/rcon.sh
      '';
      mcPerms = ''
        chown -R ${mod.owner}:services ./
      '';
    };

    networking.firewall.allowedTCPPorts = [ mod.port ];

    systemd.services."minecraft-${mod.packName}" = {
      description = "Minecraft Server";
      after = [ "network.target" ];

      serviceConfig = {
        User = mod.owner;
        Group = "services";
        WorkingDirectory = mod.data-directory;

        ExecStart = "${pkgs.bash}/bin/bash -c '${mod.javaPackage}/bin/java ${mod.runArgs}'";

        ExecStop = "${pkgs.mcrcon}/bin/mcrcon -w 2 -P ${toString mod.rconPort} -p $(cat ${rconPassword}) save-all stop";

        TimeoutStopSec = "60s";
        KillMode = "mixed";

        ReadWritePaths = [ mod.data-directory ];
        NoNewPrivileges = true;

        Restart = if mod.autoStart then "on-failure" else "no";
        RestartSec = "10s";
      };
    } // mkIf mod.autoStart {
      wantedBy = [ "multi-user.target" ];
    };
  };

}