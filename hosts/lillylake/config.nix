{
  ...
}:
{
  host = {
    localIpAddress = "192.168.0.189";
    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIv464AZB6omIM7lrgKqZKnK62iP72YOrcYsV9pplsyF lillypond@lillypond";
  };
  modules = {
    vsCode = {
      enable = true;
    };

    tailscale = {
      enable = true;
    };
  };
}
