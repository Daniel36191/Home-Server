{
  pkgs,
  ...
}:
let
  serviceName = "test1";
  workingDir = "/services/arion/test1";
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
              ${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.4.0/unix_args.txt "$@"
            '' ];

            ports = [
              "25500:25500/tcp"
            ];

            volumes = [
              "${workingDir}:/${serviceName}"
            ];

            useHostStore = true;
            restart = "always";
            stop_signal = "SIGINT";
          };
        };
      };
    };
  };
}