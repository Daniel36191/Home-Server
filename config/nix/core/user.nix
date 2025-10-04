{
  pkgs,
  options,
  username,
  ...
}:
{
  ## Define users by nix
  users = {
    mutableUsers = true;
  };

  ## Locale Settings
  console.keyMap = "us";
  ## Set your time zone
  time.timeZone = "America/New_York";
  ## Set time server
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  location.provider = "geoclue2"; ## Auto Location

  ## Select internationalisation properties
  i18n = let 
    locale = "en_US.UTF-8";
  in{
    defaultLocale = locale;
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

 ## Setup user
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${username}";
      shell = pkgs.bash;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "libvirt-qemu"
        "kvm"
        "input"
        "disk"
        "scanner"
        "lp"
        "docker"
        "podman"
        "video"
        "dialout"
      ];
    };
  };
  environment.shells = with pkgs; [
    bashInteractive
  ];
}