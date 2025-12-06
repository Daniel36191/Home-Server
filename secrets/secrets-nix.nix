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
    "user-pass" = {
      file = ./copyparty-user-daniel.age;
      owner = "copyparty";
    };
  };
}