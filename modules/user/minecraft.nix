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
    enable = mkEnableOption "Minecraft";

    port = mkOption { default = 25565; };

    data-directory = mkOption { default = "/services/minecraft"; };

    runCommand = mkOption { default = ""; };
  };

  config = {
    virtualisation.arion.projects."${serviceName}" = {
      serviceName = "${serviceName}"; ## Systemd service name ex: arion-${serviceName}
      settings = {
        project.name = "${serviceName}";
        services = {
          "${serviceName}" = {
            image = {
              name = "${serviceName}";
              enableRecommendedContents = true; ## https://docs.hercules-ci.com/arion/options#_services_name_image_enablerecommendedcontents
            };
            service = {
              command = [ "sh" "-c" ''
                "${pkgs.writeShellScript "minecraft-wrapper" ''
                  set -e
                  cd "/${serviceName}"
                  
                  ## Function to save and stop the server
                  savestop() {
                    echo "stop" > /proc/1/fd/0
                    wait $java_pid
                    exit 0
                  }
                  trap 'savestop' SIGTERM SIGINT

                  ${mod.runCommand} &
                  java_pid=$!
                  
                  wait $java_pid
                ''}"''];

              ports = [
                "${builtins.toString mod.port}:25565/tcp"
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
