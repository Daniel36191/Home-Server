{
  pkgs,
  ...
}:
{
  modules = {
    authentik = {
      enable = true;
      port = 3443;
      domain = "auth";
      public = true;

      homepage = true;
    };

    portainer = {
      enable = true;
      port = 8443;
      secure = true;
      public = true;
      domain = "portainer";

      abbr = "PT";
      homepage = true;
    };

    proxmox = {
      enable = false;
      port = 8006;

      abbr = "PX";
      homepage = true;
    };

    syncthing = {
      enable = true;
      port = 8384;

      abbr = "ST";
      homepage = true;
    };

    copyparty = {
      enable = true;
      port = 3923;
      domain = "files";
      public = true;
      secure = false;

      abbr = "FS";
      homepage = true;
      
      owner = "copyparty";
      data-directory = "/services/copyparty";
    };

    home-assistant = {
      enable = true;
      port = 8123;
      domain = "auto";

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
      port = 8125;
      domain = "home";
      public = true;
      secure = false;
      authentik-auth = true;
      default = true;
    };

    immich = {
      enable = true;
      port = 2283;
      public = true;
      secure = false;

      homepage = true;

      data-directory = "/services/immich";
      owner = "immich";
    };

    minecraft = { ## Set rcon password in secrets
      enable = true;
      port = 25500;
      url = false;
    
      data-directory = "/services/minecraft/DeceasedCraft-old";
      owner = "minecraft";

      packName = "DeceasedCraft";
      autoStart = false;
      runArgs = ''-Xmx6G -Xms4G -p libraries/cpw/mods/bootstraplauncher/1.0.0/bootstraplauncher-1.0.0.jar:libraries/cpw/mods/securejarhandler/1.0.8/securejarhandler-1.0.8.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/net/minecraftforge/JarJarFileSystems/0.3.19/JarJarFileSystems-0.3.19.jar --add-modules ALL-MODULE-PATH --add-opens java.base/java.util.jar=cpw.mods.securejarhandler --add-opens java.base/java.lang.invoke=cpw.mods.securejarhandler --add-exports java.base/sun.security.util=cpw.mods.securejarhandler --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djava.net.preferIPv6Addresses=system -DignoreList=bootstraplauncher-1.0.0.jar,securejarhandler-1.0.8.jar,asm-commons-9.5.jar,asm-util-9.5.jar,asm-analysis-9.5.jar,asm-tree-9.5.jar,asm-9.5.jar,JarJarFileSystems-0.3.19.jar -DlibraryDirectory=libraries -DlegacyClassPath=libraries/cpw/mods/securejarhandler/1.0.8/securejarhandler-1.0.8.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/net/minecraftforge/accesstransformers/8.0.4/accesstransformers-8.0.4.jar:libraries/org/antlr/antlr4-runtime/4.9.1/antlr4-runtime-4.9.1.jar:libraries/net/minecraftforge/eventbus/5.0.3/eventbus-5.0.3.jar:libraries/net/minecraftforge/forgespi/4.0.15-4.x/forgespi-4.0.15-4.x.jar:libraries/net/minecraftforge/coremods/5.0.1/coremods-5.0.1.jar:libraries/cpw/mods/modlauncher/9.1.3/modlauncher-9.1.3.jar:libraries/net/minecraftforge/unsafe/0.2.0/unsafe-0.2.0.jar:libraries/com/electronwill/night-config/core/3.6.4/core-3.6.4.jar:libraries/com/electronwill/night-config/toml/3.6.4/toml-3.6.4.jar:libraries/org/apache/maven/maven-artifact/3.6.3/maven-artifact-3.6.3.jar:libraries/net/jodah/typetools/0.8.3/typetools-0.8.3.jar:libraries/net/minecrell/terminalconsoleappender/1.2.0/terminalconsoleappender-1.2.0.jar:libraries/org/jline/jline-reader/3.12.1/jline-reader-3.12.1.jar:libraries/org/jline/jline-terminal/3.12.1/jline-terminal-3.12.1.jar:libraries/org/spongepowered/mixin/0.8.5/mixin-0.8.5.jar:libraries/org/openjdk/nashorn/nashorn-core/15.3/nashorn-core-15.3.jar:libraries/net/minecraftforge/JarJarSelector/0.3.19/JarJarSelector-0.3.19.jar:libraries/net/minecraftforge/JarJarMetadata/0.3.19/JarJarMetadata-0.3.19.jar:libraries/net/minecraftforge/fmlloader/1.18.2-40.2.4/fmlloader-1.18.2-40.2.4.jar:libraries/net/minecraft/server/1.18.2-20220404.173914/server-1.18.2-20220404.173914-extra.jar:libraries/com/github/oshi/oshi-core/5.8.5/oshi-core-5.8.5.jar:libraries/com/google/code/gson/gson/2.8.9/gson-2.8.9.jar:libraries/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:libraries/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar:libraries/com/mojang/authlib/3.3.39/authlib-3.3.39.jar:libraries/com/mojang/brigadier/1.0.18/brigadier-1.0.18.jar:libraries/com/mojang/datafixerupper/4.1.27/datafixerupper-4.1.27.jar:libraries/com/mojang/javabridge/1.2.24/javabridge-1.2.24.jar:libraries/com/mojang/logging/1.0.0/logging-1.0.0.jar:libraries/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar:libraries/io/netty/netty-all/4.1.68.Final/netty-all-4.1.68.Final.jar:libraries/it/unimi/dsi/fastutil/8.5.6/fastutil-8.5.6.jar:libraries/net/java/dev/jna/jna/5.10.0/jna-5.10.0.jar:libraries/net/java/dev/jna/jna-platform/5.10.0/jna-platform-5.10.0.jar:libraries/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar:libraries/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar:libraries/org/apache/logging/log4j/log4j-api/2.17.0/log4j-api-2.17.0.jar:libraries/org/apache/logging/log4j/log4j-core/2.17.0/log4j-core-2.17.0.jar:libraries/org/apache/logging/log4j/log4j-slf4j18-impl/2.17.0/log4j-slf4j18-impl-2.17.0.jar:libraries/org/slf4j/slf4j-api/1.8.0-beta4/slf4j-api-1.8.0-beta4.jar cpw.mods.bootstraplauncher.BootstrapLauncher --launchTarget forgeserver --fml.forgeVersion 40.2.4 --fml.mcVersion 1.18.2 --fml.forgeGroup net.minecraftforge --fml.mcpVersion 20220404.173914'';
      javaPackage = pkgs.javaPackages.compiler.temurin-bin.jre-17;
    };

    radicale = {
      enable = true;
      port = 5232;
      secure = false;
      domain = "radicale";
      public = true;


      data-directory = "/services/radicale";
      owner = "radicale";
    };

    vaultwarden = {
      enable = true;
      port = 8222;
      secure = false;
      domain = "vault";
      public = true;

      data-directory = "/services/vaultwarden";
    };

    kuma = {
      enable = true;
      port = 8484;
      secure = false;
      domain = "kuma";
      public = true;

      data-directory = "/services/kuma";
    };

    forgejo = { ## Set authentikClientSecret in secrets
    	enable = true;
    	port = 3000;
    	secure = false;
    	domain = "git";
    	public = true;

    	abbr = "Git";
    	homepage = true;

    	data-directory = "/services/git";
    	owner = "forgejo";
    	
      authentikClientId = "Rn13Cn2yj50mU4Ru9Ti7BIuPfdNx67w9PNa5IRy1";
    };
  };
}
