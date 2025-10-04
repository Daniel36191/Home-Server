{
  description = "NixOS";
  inputs = {
    #############
    ## Nixpkgs ##
    #############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-old.url = "github:nixos/nixpkgs/24.11";


    ##########
    ## Pins ##
    ##########

    nixpkgs-spotifyPin.url = "github:nixos/nixpkgs/6eb01a67e1fc558644daed33eaeb937145e17696"; ## spotify version 1.2.48.405.gf2c48e6f
    # nixpkgs-spotifyPin.url = "github:nixos/nixpkgs/e6f23dc08d3624daab7094b701aa3954923c6bbb"; ## spotify version 1.2.60.564.gcc6305cb ## Now playing bugged 


    ############
    ## Inputs ##
    ############

    ## Apps ##
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blender-cuda.url = "github:edolstra/nix-warez?dir=blender"; ## Blender-bin (now with cuda)
    lemonake.url = "github:passivelemon/lemonake"; ## For vr apps
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr"; ## for proton-ge-rstp
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
    inputs.hyprland.follows = "hyprland";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## System ##
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/master";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master"; ## For Framework
    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-old,
      home-manager,
      nix-flatpak,
      blender-cuda,
      lemonake,
      nixpkgs-xr,
      nixpkgs-spotifyPin,
      hyprsplit,
      quickshell,
      agenix,
      # nixos-hardware,
      ...
    }@inputs:
    let
      inherit (import ./config/variables-global.nix)
        gitUsername
        gitEmail
        system
        keyboardLayout
        consoleKeyMap
        locale
        timeZone
        ;
      
      ## Common function to create arguments for systems
      commonArgs = host: hostVars: {
        nix-host = host;
        inherit gitUsername gitEmail system keyboardLayout;
        inherit consoleKeyMap locale timeZone inputs;
        inherit (hostVars) username hostname wallpaper firewall;
        
        ## Pinning Nixpkgs versions
        pkgs-spotifyPin = import nixpkgs-spotifyPin {
          inherit system;
          config.allowUnfree = true;
        };
        nixpkgs-xr = import nixpkgs-xr {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-old = import nixpkgs-old {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      commonModules = [
        nixpkgs-xr.nixosModules.nixpkgs-xr 
        inputs.stylix.nixosModules.stylix
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
      ];
    in
    {

      ########
      ## Pc ##
      ########

      nixosConfigurations = {
        "pc" = nixpkgs.lib.nixosSystem {
          specialArgs = let
            pcVars = import ./config/pc/variables-pc.nix;
          in commonArgs "pc" pcVars;
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              home-manager.extraSpecialArgs = let
                pcVars = import ./config/pc/variables-pc.nix;
              in commonArgs "pc" pcVars;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${(import ./config/variables.nix).username} = import ./config/hm-main.nix;
              };
            }
            ./config/pc/nix-main-pc.nix
          ] ++ commonModules;
        };
      };
}