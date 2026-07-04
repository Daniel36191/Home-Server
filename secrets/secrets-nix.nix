{
  inputs,
  config,
  vars,
  lib,
  ...
}:
with lib;
let
  mods = config.modules;
in
{
  environment.systemPackages = [
    ## Cli tool
    inputs.agenix.packages.${vars.system}.default
  ];

  age.secrets = {
    ## SSH
    "ssh" = {
      file = ./ssh.age;
    };

    ## Copyparty
    "copyparty-user-daniel" = mkIf mods.copyparty.enable {
      file = ./copyparty-user-daniel.age;
      owner = mods.copyparty.owner;
    };

    ## Nextcloud
    "nextcloud-user-admin" = {
      file = ./nextcloud-user-admin.age;
    };

    ## Tailscale
    "tailscale-user-admin" = {
      file = ./tailscale-user-lillypond.age;
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

    ## Duckdns
    "duckdns-token" = {
      file = ./duckdns-token.age;
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

    ## Caldav
    "radicale-creds" = mkIf mods.radicale.enable {
      file = ./radicale-creds.age;
      owner = mods.radicale.owner;
    };

    ## Vaultwarden
    "vaultwarden-admin-token" = {
      file = ./vaultwarden-admin-token.age;
    };

    ## Minecraft
    "minecraft-rcon" = lib.mkIf mods.minecraft.enable {
      file = ./minecraft-rcon.age;
      group = "services";
      owner = mods.minecraft.owner;
    };

    ## Forgejo
    "authentikClientSecret" = mkIf mods.forgejo.enable {
      file = ./authentikClientSecret.age;
      group = "forgejo";
      owner = mods.forgejo.owner;
    };
    "forgejo-runner-token" = mkIf mods.forgejo.enable {
      file = ./forgejo-runner-token.age;
      group = "forgejo";
      owner = mods.forgejo.owner;
    };
    "forgesync" = {
      file = ./forgesync.age;
    };
  };
}
