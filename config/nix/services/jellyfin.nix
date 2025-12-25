{
  config,
  ...
}:{
  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  #   dataDir = "/services/jellyfin/data";
  # };
  services.jellarr = {
    enable = true;
    user = "jellyfin";
    group = "jellyfin";
    bootstrap = {
      enable = true;
      apiKeyFile = config.age.secrets."jellyfin-api-jellarr".path;
      jellyfinDataDir = "/services/jellyfin/data";
      ## Optional
      # apiKeyName = "jellarr";
      # jellyfinService = "jellyfin.service";
    };
    config = {
      version = 1;
      base_url = "http://localhost:8096";
      system = {
        enableMetrics = false;  ## Prometheus
        pluginRepositories = [
          {
            name = "Jellyfin Official";
            url = "https://repo.jellyfin.org/releases/plugin/manifest.json";
            enabled = true;
          }
        ];
        trickplayOptions = {
          enableHwAcceleration = true;
          enableHwEncoding = true;
        };
      };
      encoding = {
        enableHardwareEncoding = true;
        hardwareAccelerationType = "vaapi";
        vaapiDevice = "/dev/dri/renderD128";
        hardwareDecodingCodecs = [
          "h264"
          "hevc"
          "mpeg2video"
          "vc1"
          "vp8"
          "vp9"
          "av1"
        ];
        enableDecodingColorDepth10Hevc = true;
        enableDecodingColorDepth10Vp9 = true;
        enableDecodingColorDepth10HevcRext = true;
        enableDecodingColorDepth12HevcRext = true;
        allowHevcEncoding = false;
        allowAv1Encoding = false;
      };
      library = {
        virtualFolders = [
          {
            name = "Media";
            collectionType = "movies";
            libraryOptions = {
              pathInfos = [
                {
                  path = "/services/jellyfin/Movies";
                }
              ];
            };
          }
        ];
      };
      branding = {
        loginDisclaimer = ''
          Configured by <a href="https://github.com/venkyr77/jellarr">Jellarr</a>
        '';
        customCss = ''
          @import url("https://cdn.jsdelivr.net/npm/jellyskin@latest/dist/main.css");
        '';
        splashscreenEnabled = false;
      };
      users = [
        {
          name = "Family";
          passwordFile = config.age.secrets."jellyfin-user-family".path;
        }
        {
          name = "Admin";
          passwordFile = config.age.secrets."jellyfin-user-admin".path;
          policy = {
            isAdministrator = true;
            loginAttemptsBeforeLockout = 3;
          };
        }
      ];
      startup = {
        completeStartupWizard = true;
      };
    };
  };
}