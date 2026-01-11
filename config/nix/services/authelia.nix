{
  services,
  username,
  ...
}:
let
  mod = services.authetia;
in
{
  services.authetia.instances."${username}" = {
    enable = true;
    user = mod.owner;
    name = "${username}";
    group = "services";
    settings = {
      theme = "dark";
      default_2fa_method = "totp";
      log.level = "debug";
      telemetry.metrics.enabled = false;
    };
  };
}