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
    "ssh.age" = {
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

    ## tailscale
    "tailscale-user-admin" = {
      file = ./tailscale-user-lillypond.age;
    };

    
  };
}