{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    kitty
    git
    lazygit
    micro
  ];
}