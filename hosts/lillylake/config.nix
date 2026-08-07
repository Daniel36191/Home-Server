{
  ...
}:
{
  host = {
    localIpAddress = "192.168.0.189";
    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKE5Sk42zj5A4bzha9+RSVGrWL983GCFS3joKYIWN4QK lillypond@lillypond";
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
