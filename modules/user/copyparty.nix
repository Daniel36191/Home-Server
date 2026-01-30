{
  config,
  inputs,
  lib,
  ...
}:
with lib;
let
  mod = config.modules.copyparty;
in
{
  config = mkIf mod.enable {
    nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

    services.copyparty = {
      enable = true;
      ## The user to run the service as
      user = mod.owner;
      ## The group to run the service as
      group = "services";
      ## Directly maps to values in the [global] section of the copyparty config.
      ## See `copyparty --help` for available options
      settings = {
        i = "0.0.0.0"; ## Allowed ip/s
        p = [ mod.port ]; ## Port/s
        no-reload = true;
        rproxy = "1";
        xff-hdr = "x-forwarded-for";
      };

      ## Create users
      accounts = {
        daniel.passwordFile = config.age.secrets."copyparty-user-daniel".path;
      };
      groups = {
        admin = [
          "daniel"
        ];
      };

      volumes = {
        ## Create a volume at "/" (the webroot), which will
        "/Public" = {
          ## Storage Path
          path = mod.data-directory;
          access.rw = "*"; ## Everyone gets read-access

          ## See `copyparty --help-flags` for available options
          flags = {
            ## Enables filekeys (necessary for upget permission) (4 chars long)
            fk = 4;
            ## Scan for new files every 60sec
            scan = 60;
            ## Skips hashing file contents if path matches *.iso
            nohash = "\.iso$";
          };
        };
      };
    };
  };
}