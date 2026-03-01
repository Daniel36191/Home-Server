{
  pkgs,
  pkgs-otterwiki,
  ...
}:
let
in
{
  environment.systemPackages = with pkgs; [
    kitty
    git
    lazygit
    micro
    nh
    vscode
    neovim
    uutils-coreutils-noprefix

    ## Language servers
    nixd
    nil
    nixfmt
  ];
}
