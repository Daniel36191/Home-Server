{
  pkgs,
  ...
}:
let
  serviceName = "minecraft";
  workingDir = "/services/arion/test1";
in
{
  virtualisation.arion.projects.example = {
    serviceName = "${serviceName}"; # optional systemd service name, defaults to arion-example in this case
    settings = {
      project.name = "${serviceName}";
      services = {
        "${serviceName}" = {
          image.name = "test1";
          image.enableRecommendedContents = true; ## https://docs.hercules-ci.com/arion/options#_services_name_image_enablerecommendedcontents
          service = {
            command = [ "sh" "-c" ''
              cd "/project"
              ls -al
            '' ];
            # ${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java 

            ports = [
              "25500:25565/tcp"
            ];

            service.volumes = [
              "${workingDir}:/project"
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