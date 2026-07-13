{
  pkgs,
  options,
  vars,
  config,
  inputs,
  lib,
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
  ## Auto Location
  location.provider = "geoclue2";

  ## Select internationalisation properties
  i18n =
    let
      locale = "en_US.UTF-8";
    in
    {
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

  ## Setup Services group
  users.groups =
    let
      enabledServices = lib.filterAttrs (_: cfg: (cfg.enable or false)) config.modules;
      optionsAttrs = lib.concatMapAttrs (name: cfg: {
        ${name} = cfg.data.owner;
      }) enabledServices;
      list = builtins.attrValues optionsAttrs;
      extraMembers = [
        "root"
        "${vars.username}"
        "caddy"
      ];
      members = lib.unique (list ++ extraMembers);
    in
    {
      "services" = {
        members = members;
      };
    };

  ## Setup user
  users.users = {
    "${vars.username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${vars.username}";
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
      openssh.authorizedKeys.keys = [
      ]
      ++ inputs.workstations.publicSSHKeys;
    };
  };
  nix.settings.trusted-users = [
    "root"
    "${vars.username}"
  ];
  environment = {
    shells = with pkgs; [
      bashInteractive
    ];
    shellAliases = {
      sudonix = "git pull && nh os switch -H server ./";
      updatenix = "git pull && nh os switch -H server ./ --update";
      cleannix = "sudo nix-collect-garbage -d";

      mi = "${pkgs.micro}/bin/micro";

      log = "journalctl -xef -u";
      logs = "journalctl -xe -u";
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
    allowSFTP = true;
    settings = {
      PasswordAuthentication = true;
      ## AllowUsers Allows all users by default. Can be [ "user1" "user2" ]
      AllowUsers = null;
      UseDns = false;
      X11Forwarding = false;
      ## PermitRootLogin "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      PermitRootLogin = "yes";
      PubkeyAuthentication = "yes";
    };
  };

  age.secrets = {
    "ssh" = {
      path = "/home/${vars.username}/.ssh/id_ed25519";
      owner = vars.username;
      mode = "600";
    };
  };

  ## SSH Client & Git Auth
  home-manager.users.${vars.username} =
    let
      ssh-private = config.age.secrets."ssh";
    in
    {
      vars,
      ...
    }:
    {
      home.file.".ssh/id_ed25519.pub" = {
        text = vars.sshPublicKey;
        force = true;
      };
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

          "ssh.lillypond.name" = {
            hostname = "ssh.lillypond.name";
            port = 2222;
            user = "forgejo";
            extraOptions = {
              WarnWeakCrypto = "no";
            };
          };

          "github.com" = {
            hostname = "github.com";
            port = 22;
            user = "git";
          };
        };
      };
      programs.git = {
        enable = true;
        settings.user = {
          Name = "Daniel36191";
          Email = "${vars.email}";
        };
      };
      programs = {
        gh.enable = true;
      };
    };

}
