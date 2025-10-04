{
    username,
    ...
}:
{
  ## Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
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