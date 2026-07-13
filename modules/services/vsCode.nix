{
  config,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.vsCode;
in
{
  options.modules.vsCode = {

  };
  config = mkIf mod.enable {
    services.vscode-server = {
      enable = true;
      enableFHS = true;
      extraRuntimeDependencies = with pkgs; [
        git
        nixfmt
        nixd
        nil
        devenv
      ];
    };
  };
}
