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
      homepage = {
        homepage = true;
      };
    };

    portainer = {
      enable = true;
      proxy = {
        port = 8443;
        secure = true;
        public = true;
        domain = "portainer";
      };
      homepage = {
        abbr = "PT";
        homepage = true;
      };
    };

    proxmox = {
      enable = false;
      proxy = {
        port = 8006;
      };
      homepage = {
        abbr = "PX";
        homepage = true;
      };
    };

    syncthing = {
      enable = true;
      proxy = {
        port = 8384;
      };
      homepage = {
        abbr = "ST";
        homepage = true;
      };
    };

    copyparty = {
      enable = true;
      proxy = {
        port = 3923;
        domain = "files";
        public = true;
        secure = false;
      };
      homepage = {
        abbr = "FS";
        homepage = true;
      };
      data = {
        owner = "copyparty";
        data-directory = "/services/copyparty";
      };
    };

    home-assistant = {
      enable = false;
      proxy = {
        port = 8123;
        domain = "auto";
      };
      homepage = {
        abbr = "HA";
        homepage = true;
      };
      data = {
        data-directory = "/services/home-assistant";
      };
      settings = {
        ##Set to true to edit dashboard in ui, copy file yaml file next to home-assistant.nix then rebuild.
        love-config-writeable = true;
        connectors = [
        ];
        lovelace-modules = with pkgs.home-assistant-custom-lovelace-modules; [
          mini-graph-card
        ];
      };
    };

    homepage = {
      enable = true;
      proxy = {
        port = 8125;
        domain = "home";
        public = true;
        secure = false;
        authentik-auth = true;
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
      homepage = {
        homepage = true;
      };
      data = {
        data-directory = "/services/immich";
        owner = "immich";
      };
    };

    minecraft = {
      ## Set rcon password in secrets
      enable = false;
      proxy = {
        port = 25500;
        url = false;
      };
      data = {
        data-directory = "/services/minecraft/DeceasedCraft-old";
        owner = "minecraft";
      };
      settings = {
        packName = "DeceasedCraft";
        autoStart = false;
        runArgs = "-Xmx6G -Xms4G -p libraries/cpw/mods/bootstraplauncher/1.0.0/bootstraplauncher-1.0.0.jar:libraries/cpw/mods/securejarhandler/1.0.8/securejarhandler-1.0.8.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/net/minecraftforge/JarJarFileSystems/0.3.19/JarJarFileSystems-0.3.19.jar --add-modules ALL-MODULE-PATH --add-opens java.base/java.util.jar=cpw.mods.securejarhandler --add-opens java.base/java.lang.invoke=cpw.mods.securejarhandler --add-exports java.base/sun.security.util=cpw.mods.securejarhandler --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djava.net.preferIPv6Addresses=system -DignoreList=bootstraplauncher-1.0.0.jar,securejarhandler-1.0.8.jar,asm-commons-9.5.jar,asm-util-9.5.jar,asm-analysis-9.5.jar,asm-tree-9.5.jar,asm-9.5.jar,JarJarFileSystems-0.3.19.jar -DlibraryDirectory=libraries -DlegacyClassPath=libraries/cpw/mods/securejarhandler/1.0.8/securejarhandler-1.0.8.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/net/minecraftforge/accesstransformers/8.0.4/accesstransformers-8.0.4.jar:libraries/org/antlr/antlr4-runtime/4.9.1/antlr4-runtime-4.9.1.jar:libraries/net/minecraftforge/eventbus/5.0.3/eventbus-5.0.3.jar:libraries/net/minecraftforge/forgespi/4.0.15-4.x/forgespi-4.0.15-4.x.jar:libraries/net/minecraftforge/coremods/5.0.1/coremods-5.0.1.jar:libraries/cpw/mods/modlauncher/9.1.3/modlauncher-9.1.3.jar:libraries/net/minecraftforge/unsafe/0.2.0/unsafe-0.2.0.jar:libraries/com/electronwill/night-config/core/3.6.4/core-3.6.4.jar:libraries/com/electronwill/night-config/toml/3.6.4/toml-3.6.4.jar:libraries/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar -DignoreList=bootstraplauncher-1.0.0.jar,securejarhandler-1.0.8.jar,asm-commons-9.5.jar,asm-util-9.5.jar,asm-analysis-9.5.jar,asm-tree-9.5.jar,asm-9.5.jar,JarJarFileSystems-0.3.19.jar,accesstransformers-8.0.4.jar,antlr4-runtime-4.9.1.jar,eventbus-5.0.3.jar,forgespi-4.0.15-4.x.jar,coremods-5.0.1.jar,modlauncher-9.1.3.jar,unsafe-0.2.0.jar,night-config-core-3.6.4.jar,night-config-toml-3.6.4.jar,commons-lang3-3.12.0.jar";
        javaPackage = pkgs.javaPackages.compiler.temurin-bin.jre-17;
      };
    };

    radicale = {
      enable = true;
      proxy = {
        port = 5232;
        secure = false;
        domain = "radicale";
        public = true;
      };
      data = {
        data-directory = "/services/radicale";
        owner = "radicale";
      };
    };

    vaultwarden = {
      enable = true;
      proxy = {
        port = 8222;
        secure = false;
        domain = "vault";
        public = true;
      };
      data = {
        data-directory = "/services/vaultwarden";
      };
    };

    kuma = {
      enable = true;
      proxy = {
        port = 8484;
        secure = false;
        domain = "kuma";
        public = true;
      };
      data = {
        data-directory = "/services/kuma";
      };
    };

    forgejo = {
      ## Set authentikClientSecret in secrets
      ## Port forwar 2222 through cloudflare
      enable = true;
      proxy = {
        port = 3000;
        secure = false;
        domain = "git";
        public = true;
      };
      homepage = {
        abbr = "Git";
        homepage = true;
      };
      data = {
        data-directory = "/services/forgejo";
        owner = "forgejo";
      };
      settings = {
        ## Setup all keys for https://hack.moontide.ink/helvetica/forgesync : SOURCE(forgejo), TARGET(github), MIRROR(github)
        forgeSync = true;
        authentikClientId = "Rn13Cn2yj50mU4Ru9Ti7BIuPfdNx67w9PNa5IRy1";
        sshPort = 2222;
        ## Generate key and place in age from web-ui
        runnerEnable = false;
        runnerLabels = [
          "native:host"
          "ubuntu-latest:docker://node:20-bookworm"
          "ubuntu-24.04:docker://node:20-bookworm"
        ];
      };
    };

    vsCode = {
      enable = true;
      proxy.url = true;
    };
  };
}
