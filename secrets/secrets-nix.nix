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
      file = ./copypary-user-daniel.age;
      owner = "copyparty";
    };
  };
}