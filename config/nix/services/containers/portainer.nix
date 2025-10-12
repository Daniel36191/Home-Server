{
  ...
}:
{
  services.portainer = {
    enable = true;
    version = "latest";
    openFirewall = true;
    port = 9443; ## WebUi port
  };
}