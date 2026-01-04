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
              cd "/${serviceName}"
              ${runCommand}
            '' ];

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