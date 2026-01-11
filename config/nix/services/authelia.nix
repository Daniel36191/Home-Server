{
  config,
  services,
  username,
  ...
}:
let
  mod = services.authelia;
in
{
  services.authelia.instances."${username}" = {
    enable = true;
    user = mod.owner;
    name = "${username}";
    group = "services";
    secrets = { 
      jwtSecretFile = config.age.secrets."authelia-jwtsecret".path;
      storageEncryptionKeyFile = config.age.secrets."authelia-encryptionkey".path;
    };  
    settings = {
      theme = "dark";
      default_2fa_method = "totp";
      log.level = "debug";
      telemetry.metrics.enabled = false;
    };
  };
}