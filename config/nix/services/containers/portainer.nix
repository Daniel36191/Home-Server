{
  services,
  lib,
  ...
}:
{
  services.portainer = {
    enable = true;
    version = "latest";
    openFirewall = true;
    port = services.portainer.port; ## WebUi port
  };
}