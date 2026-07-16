{
  lib,
  modulesFolder,
  hostsFolder,
  ...
}:
with lib;
let
  ######################
  ## Generate Modules ##
  ######################
  nixFiles = builtins.filter (p: lib.hasSuffix ".nix" (toString p)) (
    lib.filesystem.listFilesRecursive modulesFolder
  );
  parseFile =
    path:
    let
      str = toString path;
      relPath = builtins.elemAt (builtins.split "/modules/" str) 2;
      segs = lib.splitString "/" relPath;
      rest = builtins.tail segs; # drop section
      stem = lib.removeSuffix ".nix" (lib.last rest);
      group = if builtins.length rest > 1 then builtins.head rest else null;
    in
    {
      inherit stem group;
      depth = builtins.length rest;
    };
  parsed = map parseFile nixFiles;
  servicesList = lib.unique (map (p: p.stem) (builtins.filter (p: p.depth == 1) parsed));

  generateModuleOptions = listToAttrs (
    map (name: {
      name = name;
      value = {
        enable = mkEnableOption "${name}";
        proxy = {
          enable = mkEnableOption "Enable Proxy";
          port = mkOption { default = 0; };
          secure = mkOption { default = true; };
          authentikAuth = mkOption { default = false; }; # Use authentik proxy auth for protection
          domain = mkOption { default = "${name}"; };
          public = mkOption { default = false; };
          default = mkOption { default = false; };
        };

        homepage = {
          abbr = mkOption { default = "${toUpper (substring 0 2 name)}"; };
          homepage = mkOption { default = false; };
          icon = mkOption { default = "${name}"; };
        };

        data = {
          owner = mkOption { default = "${name}"; };
          dataDirectory = mkOption { default = "/services/${name}"; };
        };

      };
    }) servicesList
  );

  ##############
  ## SSH Keys ##
  ##############
  nixConfigFiles = builtins.filter (p: lib.hasSuffix "config.nix" (toString p)) (
    allFiles hostsFolder
  );
  hostSSHKeys = lib.forEach nixConfigFiles (p: (import p { }).hostConf.sshPublicKey);

  ############
  ## MkHost ##
  ############
  mkHost =
    imports: host: extraNixModules: extraHmImports:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = imports.commonArgs // {
        inherit host;
      };
      modules = [
        {
          nixpkgs.config.allowUnfree = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = imports.commonArgs // {
              inherit host;
            };
            users.${host}.imports = imports.commonHmModules ++ extraHmImports ++ [ ];
          };
        }
      ]
      ++ imports.commonNixModules
      ++ extraNixModules;
    };
in
{
  inherit generateModuleOptions;
  inherit hostSSHKeys;
  inherit mkHost;
}
