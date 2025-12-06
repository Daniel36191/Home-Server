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
    "copyparty-user-daniel" = {
      file = ./copyparty-user-daniel.age;
      owner = "copyparty";
    };
  };
}