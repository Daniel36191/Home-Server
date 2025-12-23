{
  pkgs,
  options,
  username,
  config,
  ssh-public-key,
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
  environment = { 
    shells = with pkgs; [
      bashInteractive
    ];
    shellAliases = {
      sudonix = "git pull && nh os switch -H server ./";
      updatenix = "git pull && nh os switch -H server ./ --update";
      cleannix = "sudo nix-collect-garbage -d";
    };
  };

  #########
  ## SSH ##
  #########

  ## SSH Server
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    authorizedKeysInHomedir = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; ## Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "yes"; ## "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      PubkeyAuthentication = "yes";
    };
  };

  age.secrets = {
    "ssh" = {
      path = "/home/${username}/.ssh/ssh";
      owner = username;
      mode = "600";
    };
  };

  ## SSH Client
  home-manager.users.${username} = let ssh-private = config.age.secrets."ssh"; in { pkgs, config, ssh-public-key, ... }: {
    home.file.".ssh/ssh.pub" = { text = ssh-public-key; force = true; };
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          port = 22;
          identityFile = ssh-private.path;
          forwardAgent = false;
          addKeysToAgent = "yes";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no"; 
        };

        "github.com" = {
          hostname = "github.com";
          port = 22;
          user = "git";
        };
      };
    };
  };

}