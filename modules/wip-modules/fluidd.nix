{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.fluidd;
in
{
  options.modules.fluidd.settings = {
    printerIp = mkOption { default = "127.0.0.1"; };
    printerPort = mkOption { default = "7125"; };
  };
  config = mkIf mod.enable {
    virtualisation.arion.projects."${serviceName}" = {
      serviceName = "${serviceName}";
      settings = {
        project.name = "${serviceName}";
        services = {
          "${serviceName}" = {
            image.name = "test1";
            image.enableRecommendedContents = true; # # https://docs.hercules-ci.com/arion/options#_services_name_image_enablerecommendedcontents
            service = {
              command = [
                "sh"
                "-c"
                ''
                  cd "/project"
                  ls -al
                ''
              ];
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
  };
}
