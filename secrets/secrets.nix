let
  ## Host public ssh key foubd by cat /etc/ssh/ssh_host_ed25519_key.pub
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ7DNe+NVZ74xIdEWxSOWxXkK/p+8JXtunLE+TTJXXpO";
  systems = [
    server
  ];
in
{
  ## make new files/edit with agenixedit file.age

  ## SSH
  "ssh.age".publicKeys = systems;

  ## CopyParty users
  "copyparty-user-daniel.age".publicKeys = systems;

  ## Nextcloud Users
  "nextcloud-user-admin.age".publicKeys = systems;

  ## Tailscale
  "tailscale-user-lillypond.age".publicKeys = systems;

  ## Jellyfin
  "jellyfin-api-jellarr.age".publicKeys = systems;
  "jellyfin-user-admin.age".publicKeys = systems;
  "jellyfin-user-family.age".publicKeys = systems;

  ## Duckdns
  "duckdns-token.age".publicKeys = systems;

  ## Authelia
  "authelia-jwtsecret.age".publicKeys = systems;
  "authelia-encryptionkey.age".publicKeys = systems;


}