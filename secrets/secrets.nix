let
  ## Host public ssh key foubd by cat /etc/ssh/ssh_host_ed25519_key.pub
  lillypond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ7DNe+NVZ74xIdEWxSOWxXkK/p+8JXtunLE+TTJXXpO";
  lillylake = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAAAwK9S7TWZht1c/TJJjx92SveFjdLnwnJajXDHQI9f";
  systems = [
    lillypond
    lillylake
  ];
in
{
  ## Make new files/edit with agenixedit file.age
  ## Rekey with lillypond's private key

  ## SSH
  "ssh-lillypond.age".publicKeys = systems;
  "ssh-lillylake.age".publicKeys = systems;

  ## CopyParty users
  "copyparty-user-daniel.age".publicKeys = systems;

  ## Nextcloud Users
  "nextcloud-user-admin.age".publicKeys = systems;

  ## Tailscale
  "tailscale-user-lillypond.age".publicKeys = systems;
  "tailscale-user-lillylake.age".publicKeys = systems;

  ## Jellyfin
  "jellyfin-api-jellarr.age".publicKeys = systems;
  "jellyfin-user-admin.age".publicKeys = systems;
  "jellyfin-user-family.age".publicKeys = systems;

  ## Authentik
  "authentik-env.age".publicKeys = systems;

  ## Cloudflared
  "cloudflared-token.age".publicKeys = systems;
  "cloudflared-creds.age".publicKeys = systems;

  ## Radicale
  "radicale-creds.age".publicKeys = systems;

  ## Vaultwarden
  "vaultwarden-admin-token.age".publicKeys = systems;

  ## Minecraft
  "minecraft-rcon.age".publicKeys = systems;

  ## Forgejo
  "authentikClientSecret.age".publicKeys = systems;
  "forgejo-runner-token.age".publicKeys = systems;
  "forgesync.age".publicKeys = systems;
}
