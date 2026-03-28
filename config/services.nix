{
  pkgs,
  ...
}:
{
  modules = {
    authentik = {
      enable = true;
      proxy = {
        port = 3443;
        domain = "auth";
        public = true;
      };
      homepage = true;
    };

    portainer = {
      enable = true;
      proxy = {
        port = 8443;
        secure = true;
        public = true;
        domain = "portainer";
      };

      abbr = "PT";
      homepage = true;
    };

    proxmox = {
      enable = false;
      proxy = {
        port = 8006;
      };

      abbr = "PX";
      homepage = true;
    };

    syncthing = {
      enable = true;
      proxy = {
        port = 8384;
      };

      abbr = "ST";
      homepage = true;
    };

    copyparty = {
      enable = true;
      proxy = {
        port = 3923;
        domain = "files";
        public = true;
      };

      abbr = "FS";
      homepage = true;
      
      owner = "copyparty";
      data-directory = "/services/copyparty/public"; ## Only the public folder listed here
      backups = {
      	enable = true;
      	include = [ "/services/copyparty" ]
      	exclude = [];
      };
    };

    home-assistant = {
      enable = true;
      proxy = {
        port = 8123;
        domain = "home";
        public = true;
        secure = false;
      };

      abbr = "HA";
      homepage = true;
      
      data-directory = "/services/home-assistant";

      love-config-writeable = true; ## Set to true to edit dashboard in ui, copy file yaml file next to home-assistant.nix then rebuild.
      connectors = [
      ];
      lovelace-modules = with pkgs.home-assistant-custom-lovelace-modules; [
        mini-graph-card
      ];
    };

    homepage = {
      enable = true;
      proxy = {
        port = 8125;
        domain = "homepage";
        public = true;
        secure = false;
        default = true;
      };
    };

    immich = {
      enable = true;
      proxy = {
        port = 2283;
        public = true;
        secure = false;
      };

      homepage = true;

      data-directory = "/services/immich";
      owner = "immich";
    };

    minecraft = {
      enable = true;
      proxy = {
        enable = false; ## Ip only
        port = 25500;
      };
    
      data-directory = "/services/minecraft/LiminalIndustries";
      runCommand = ''${pkgs.javaPackages.compiler.temurin-bin.jre-17}/bin/java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.4.13/unix_args.txt "$@"'';
    };

    radicale = {
      enable = true;
      proxy = {
        port = 5232;
        secure = false;
        domain = "radicale";
        public = true;
      };

      data-directory = "/services/radicale";
      owner = "radicale";
    };

    vaultwarden = {
      enable = true;
      proxy = {
        port = 8222;
        secure = false;
        domain = "vault";
        public = true;
      }; 

      data-directory = "/services/vaultwarden";
    };

    kuma = {
      enable = true;
      proxy = {
        port = 8484;
        secure = false;
        domain = "kuma";
        public = true;
      };

      data-directory = "/services/kuma";
    };

    otterwiki = {
      enable = false;
      proxy = {
        port = 8982;
        secure = false;
        domain = "wiki";
      };

      homepage = false;
    };
  };
}
