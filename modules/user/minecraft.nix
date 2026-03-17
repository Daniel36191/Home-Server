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
  permsScript = pkgs.writeShellScriptBin "mc-perms" ''
    chown -R ${mod.owner}:services ./
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

    environment.systemPackages = [ rconScript permsScript ];
    system.activationScripts.minecraft-rcon = ''
      ln -sf ${rconScript}/bin/mc-rcon ${mod.data-directory}/rcon.sh
      ln -sf ${permsScript}/bin/mc-perms ${mod.data-directory}/permsScript.sh
    '';

    networking.firewall.allowedTCPPorts = [ mod.port ];

    systemd.services."minecraft-${mod.packName}" = {
      description = "Minecraft Server";
      # wantedBy = [ "multi-user.target" ]; ## Auto start
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

        Restart = "no"; # "on-failure";
        RestartSec = "10s";
      };
    };
  };
}