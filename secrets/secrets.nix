let
  ## Host public ssh key foubd by cat /etc/ssh/ssh_host_ed25519_key.pub
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ7DNe+NVZ74xIdEWxSOWxXkK/p+8JXtunLE+TTJXXpO";
  systems = [
    server
  ];
in
{
  ## make new files/edit with agenixedit file.age
  "copypary-user-daniel.age".publicKeys = systems;
}