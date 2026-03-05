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
in
{
  options.modules.minecraft = {
    runCommand = mkOption { default = ""; };
    rconPort = mkOption { default = 25575; };
    rconPassword = mkOption { default = "changeme"; };
  };
  config = {
    virtualisation.arion.projects."${serviceName}" = {
      serviceName = "${serviceName}";
      settings = {
        project.name = "${serviceName}";
        services = {
          "${serviceName}" = {
            image = {
              name = "${serviceName}";
              enableRecommendedContents = true;
            };
            service = {
              command = [ "sh" "-c" ''
                "${pkgs.writeShellScript "minecraft-wrapper" ''
                  set -e
                  cd "/${serviceName}"

                  savestop() {
                    echo "Sending stop via RCON..."
                    ${pkgs.mcrcon}/bin/mcrcon \
                      -H 127.0.0.1 \
                      -P ${builtins.toString mod.rconPort} \
                      -p "${mod.rconPassword}" \
                      "stop" || true
                    ## Wait up to 30s for graceful shutdown
                    for i in $(seq 1 30); do
                      kill -0 "$java_pid" 2>/dev/null || break
                      sleep 1
                    done
                    ## Force kill if still running
                    
                    kill -0 "$java_pid" 2>/dev/null && kill -9 "$java_pid" || true
                    exit 0
                  }

                  trap 'savestop' SIGTERM SIGINT

                  ${mod.runCommand} &
                  java_pid=$!
                  wait $java_pid
                ''}"''];
              ports = [
                "${builtins.toString mod.port}:25565/tcp"
                "127.0.0.1:${builtins.toString mod.rconPort}:${builtins.toString mod.rconPort}/tcp"
              ];
              volumes = [
                "${mod.data-directory}:/${serviceName}"
              ];
              useHostStore = true;
              restart = "always";
              stop_signal = "SIGTERM";
            };
          };
        };
      };
    };
  };
}