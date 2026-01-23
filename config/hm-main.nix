{
    vars,
    ...
}:
{
  ## Home Manager Settings
  home = {
    username = "${vars.username}";
    homeDirectory = "/home/${vars.username}";
    stateVersion = "25.05";
  };
  programs = {
    home-manager.enable = true;
  };

  ## Create XDG Dirs (Pictures, Desktop, Docs, etc)
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

}