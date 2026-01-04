{
  pkgs,
  services,
  ...
}:
let
  serviceName = "minecraft";
  runCommand = ''${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.4.0/unix_args.txt "$@"'';
in
{
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
                
                # Function to gracefully stop the server
                graceful_stop() {
                  echo "Sending stop command to Minecraft server..."
                  echo "stop" > /proc/1/fd/0  # Send to stdin of PID 1 (the java process)
                  # Wait for the process to exit
                  wait $java_pid
                  exit 0
                }
                
                # Trap signals
                trap 'graceful_stop' SIGTERM SIGINT
                
                # Start the server in background
                ${runCommand} &
                java_pid=$!
                
                # Wait for the java process
                wait $java_pid
              ''}"''];

            ports = [
              "${builtins.toString services.minecraft.port}:25565/tcp"
            ];

            volumes = [
              "${services.minecraft.data-directory}:/${serviceName}"
            ];

            useHostStore = true;
            restart = "always";
            stop_signal = "SIGTERM";
          };
        };
      };
    };
  };
}
