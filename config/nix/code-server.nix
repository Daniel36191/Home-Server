{
  pkgs,
  ...
}:
let
in
{
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
}
