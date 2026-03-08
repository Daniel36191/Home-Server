{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  mod = config.modules.minecraft;
  serviceName = "minecraft";

  parseProperties = file:
    let
      content = builtins.readFile file;
      lines = splitString "\n" content;
      nonEmpty = filter (l: l != "" && !(hasPrefix "#" l)) lines;
      pairs = map (l: let parts = splitString "=" l; in {
        name = head parts;
        value = concatStringsSep "=" (tail parts);
      }) nonEmpty;
    in listToAttrs pairs;

  props = parseProperties "${mod.data-directory}/server.properties";

  rconPort = toInt (props."rcon.port" or "25575");
  rconPassword = props."rcon.password" or "";
  serverPort = toInt (props."server-port" or "25565");

  rconScript = pkgs.writeShellScriptBin "mc-rcon" ''
    exec ${pkgs.mcrcon}/bin/mcrcon \
      -H 127.0.0.1 \
      -P ${toString rconPort} \
      -p ${rconPassword} \
      -t
  '';
in
{
  options.modules.minecraft = {
    data-directory = mkOption {
      default = "/var/lib/minecraft";
    };
    runCommand = mkOption {
      default = ''chmod +x ./run.sh && ./run.sh'';
    };
    javaPackage = mkOption {
      default = pkgs.javaPackages.compiler.temurin-bin.jre-17;
    };
  };

  config = {
    assertions = [
      {
        assertion = (props."enable-rcon" or "false") == "true";
        message = "Minecraft: enable-rcon must be true in server.properties for graceful shutdown to work";
      }
      {
        assertion = rconPassword != "";
        message = "Minecraft: rcon.password must be set in server.properties";
      }
    ];

    users.users.${serviceName} = {
      isSystemUser = true;
      group = serviceName;
      home = mod.data-directory;
      createHome = true;
    };
    users.groups.${serviceName} = {};

    networking.firewall.allowedTCPPorts = [ serverPort ];

    environment.systemPackages = [ rconScript ];

    system.activationScripts.minecraft-rcon = ''
      ln -sf ${rconScript}/bin/mc-rcon ${mod.data-directory}/rcon.sh
    '';

    systemd.services.${serviceName} = {
      description = "Minecraft Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        User = serviceName;
        Group = serviceName;
        WorkingDirectory = mod.data-directory;

        ExecStart = "${pkgs.bash}/bin/bash -c '${javaPackag} ${mod.runCommand}'";

        ExecStop = "${pkgs.mcrcon}/bin/mcrcon -H 127.0.0.1 -P ${toString rconPort} -p ${rconPassword} stop";

        TimeoutStopSec = "60s";
        KillMode = "mixed";

        PrivateTmp = true;
        ProtectSystem = "strict";
        ReadWritePaths = [ mod.data-directory ];
        NoNewPrivileges = true;

        Restart = "on-failure";
        RestartSec = "10s";
      };
    };
  };
}