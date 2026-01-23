{
  inputs,
  config,
  vars,
  ...
}:
{
  environment.systemPackages = [
    inputs.agenix.packages.${vars.system}.default ## Cli tool
  ];

  age.secrets = {
    ## SSH
    "ssh" = {
      file = ./ssh.age;
    };

    ## Copyparty
    "copyparty-user-daniel" = {
      file = ./copyparty-user-daniel.age;
      owner = config.modules.copyparty.owner;
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
    "radicale-creds" = {
      file = ./radicale-creds.age;
      owner = config.modules.radicale.owner;
    };

    ## Vaultwarden
    "vaultwarden-admin-token" = {
      file = ./vaultwarden-admin-token.age;
    };
  };
}