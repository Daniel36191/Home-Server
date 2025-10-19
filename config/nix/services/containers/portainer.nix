{
  ...
}:
{
  services.portainer = {
    enable = false;
    version = "latest";
    openFirewall = true;
    port = 9443; ## WebUi port
  };
}