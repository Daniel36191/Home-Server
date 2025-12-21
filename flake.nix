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
    proxmox-nixos.inputs.nixpkgs.follows = "nixpkgs";

    portainer-on-nixos.url = "gitlab:cbleslie/portainer-on-nixos";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    copyparty.url = "github:9001/copyparty";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      agenix,
      proxmox-nixos,
      portainer-on-nixos,
      nix-minecraft,
      copyparty,
      ...
    }@inputs:
    let
      inherit (import ./config/variables.nix)
        system
        username
        localipaddress
        ssh-public-key
        ;
      
      ## Common function to create arguments for systems
      commonArgs = {
        inherit inputs;
        inherit 
          username
          localipaddress
          ssh-public-key
          ;
        
        ## Pinning Nixpkgs versions
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };

        proxmoxOverlay = proxmox-nixos.overlays.${system};
        minecraftoverlay = nix-minecraft.overlay;
      };
      commonModules = [
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        proxmox-nixos.nixosModules.proxmox-ve
        portainer-on-nixos.nixosModules.portainer
        nix-minecraft.nixosModules.minecraft-servers
        copyparty.nixosModules.default
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