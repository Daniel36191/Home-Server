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
    ## Copyparty
    "copyparty-user-daniel" = {
      file = ./copyparty-user-daniel.age;
      owner = "copyparty";
    };

    ## Nextcloud
    "nextcloud-user-admin" = {
      file = ./nextcloud-user-admin.age;
    };
  };
}