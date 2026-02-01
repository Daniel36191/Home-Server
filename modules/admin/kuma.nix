{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.kuma;
in
{
  config = mkIf mod.enable {
    services.uptime-kuma = {
      enable = true;
      appriseSupport = true;
      settings = {
        PORT = mkString mod.port;
        HOST="127.0.0.1";
      };
    };

    ## Has to link becasue of systemd hardneing see https://github.com/NixOS/nixpkgs/issues/324105
    system.activationScripts.uptime-kuma = ''
    if [[ -d ${mod.data-directory} ]]; then
      mkdir -p /var/lib/private
      chmod 700 /var/lib/private
      ln -s ${mod.data-directory} /var/lib/private/uptime-kuma
    fi
    '';
  };
}
