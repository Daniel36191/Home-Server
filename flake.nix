{
  description = "Home-Server";
  inputs = {
    #############
    ## Nixpkgs ##
    #############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";

    ############
    ## Inputs ##
    ############

    home-manager = {
      url = "github:nix-community/home-manager/master";
    inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };

    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      agenix,
      proxmox-nixos,
      ...
    }@inputs:
    let
      inherit (import ./config/variables.nix)
        system
        username
        ;
      
      ## Common function to create arguments for systems
      commonArgs = {
        inherit inputs;
        inherit 
          username
          ;
        
        ## Pinning Nixpkgs versions
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      commonModules = [
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        proxmox-nixos.nixosModules.proxmox-ve
      ];
    in
    {
      nixosConfigurations = {
        "server" = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              home-manager = {
                extraSpecialArgs = commonArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${(import ./config/variables.nix).username} = import ./config/hm-main.nix;
              };
            }
            ./config/nix-main.nix
          ] ++ commonModules;
        };
      };
    };
}