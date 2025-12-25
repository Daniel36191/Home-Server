{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.${system}.default ## Cli tool
  ];

  age.secrets = {
    ## SSH
    "ssh" = {
      file = ./ssh.age;
    };

    ## Copyparty
    "copyparty-user-daniel" = {
      file = ./copyparty-user-daniel.age;
      owner = "copyparty";
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
    "jellyfin-user-family" = {
      file = ./jellyfin-user-family.age;
    };
    "jellyfin-user-admin" = {
      file = ./jellyfin-user-admin.age;
    };
  };
}