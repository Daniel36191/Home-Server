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
              ls -al
            '' ];
            # ${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java 

            ports = [
              "25500:25565/tcp"
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