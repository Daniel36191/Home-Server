{
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
      jwtSecretFile = /my/path/to/jwtsecret;
      storageEncryptionKeyFile = /my/path/to/encryptionkey;
    };  
    settings = {
      theme = "dark";
      default_2fa_method = "totp";
      log.level = "debug";
      telemetry.metrics.enabled = false;
    };
  };
}