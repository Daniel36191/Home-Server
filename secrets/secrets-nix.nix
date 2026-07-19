{
  inputs,
  config,
  system,
  lib,
  ...
}:
with lib;
let
  mods = config.modules;
in
{
  environment.systemPackages = [
    inputs.agenix.packages.${system}.default
  ];

  age.secrets = {
    ## SSH
    "ssh-lillypond" = {
      file = ./ssh-lillypond.age;
    };
    "ssh-lillylake" = {
      file = ./ssh-lillylake.age;
    };

    ## Copyparty Users
    "copyparty-user-daniel" = mkIf mods.copyparty.enable {
      file = ./copyparty-user-daniel.age;
      owner = mods.copyparty.data.owner;
    };

    ## Nextcloud Users
    "nextcloud-user-admin" = {
      file = ./nextcloud-user-admin.age;
    };

    ## Tailscale
    "tailscale-user-lillypond" = {
      file = ./tailscale-user-lillypond.age;
    };
    "tailscale-user-lillylake" = {
      file = ./tailscale-user-lillylake.age;
    };

    ## Jellyfin
    "jellyfin-api-jellarr" = {
      file = ./jellyfin-api-jellarr.age;
    };
    "jellyfin-user-family" = {
      file = ./jellyfin-user-family.age;
    };
    "jellyfin-user-admin" = {
      file = ./jellyfin-user-admin.age;
    };

    ## Authentik
    "authentik-env" = {
      file = ./authentik-env.age;
    };

    ## Cloudflared
    "cloudflared-token" = {
      file = ./cloudflared-token.age;
    };
    "cloudflared-creds" = {
      file = ./cloudflared-creds.age;
    };

    ## Radicale
    "radicale-creds" = mkIf mods.radicale.enable {
      file = ./radicale-creds.age;
      owner = mods.radicale.data.owner;
    };

    ## Vaultwarden
    "vaultwarden-admin-token" = {
      file = ./vaultwarden-admin-token.age;
    };

    ## Minecraft
    "minecraft-rcon" = mkIf mods.minecraft.enable {
      file = ./minecraft-rcon.age;
      group = "services";
      owner = mods.minecraft.data.owner;
    };

    ## Forgejo
    "authentikClientSecret" = mkIf mods.forgejo.enable {
      file = ./authentikClientSecret.age;
      group = "forgejo";
      owner = "forgejo";
    };
    "forgejo-runner-token" = mkIf mods.forgejo.enable {
      file = ./forgejo-runner-token.age;
      group = "forgejo";
      owner = "forgejo";
    };
    "forgesync" = {
      file = ./forgesync.age;
    };
  };
}
