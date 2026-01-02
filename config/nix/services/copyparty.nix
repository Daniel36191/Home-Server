{
  config,
  inputs,
  services,
  ...
}:
let
in
{
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  services.copyparty = {
    enable = true;
    ## The user to run the service as
    user = services.copyparty.data-owner;
    ## The group to run the service as
    group = "services"; 
    ## Directly maps to values in the [global] section of the copyparty config.
    ## See `copyparty --help` for available options
    settings = {
      i = "0.0.0.0"; ## Allowed ip/s
      p = [ services.copyparty.port ]; ## Port/s
      ## Use booleans to set binary flags
      no-reload = true;
      ## Using 'false' will do nothing and omit the value when generating a config
      ignored-flag = false;
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
        path = services.copyparty.data-directory;
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
    ## You may increase the open file limit for the process
    openFilesLimit = 8192;
  };
}