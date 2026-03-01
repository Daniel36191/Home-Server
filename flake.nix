{
  description = "Home-Server";
  inputs = {
    #############
    ## Nixpkgs ##
    #############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    # nixpkgs-otterwiki.url = "github:nixos/nixpkgs/101422ad186fa7d20c5424428a87c42dd46464c3";

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

    jellarr.url = "github:venkyr77/jellarr";

    arion.url = "github:hercules-ci/arion";

    authentik-nix.url = "github:nix-community/authentik-nix";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
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
      jellarr,
      arion,
      authentik-nix,
      vscode-server,
      ...
    }@inputs:
    let
      vars = import ./config/variables.nix;
      
      ## Common function to create arguments for systems
      commonArgs = {
        inherit inputs;
        inherit 
          vars
          ;
        
        ## Pinning Nixpkgs versions
        pkgs-stable = import nixpkgs-stable {
          inherit vars;
          config.allowUnfree = true;
        };
        # pkgs-otterwiki = import ( pkgs.applyPatches {
        #   src = pkgs.path;
        #   patches = [
        #     (pkgs.fetchpatch2 {
        #       url = "https://github.com/NixOS/nixpkgs/pull/440513.patch";
        #       sha256 = "";
        #     })
        #   ];
        # };){
        #   inherit vars;
        #   config.allowUnfree = true;
        # };

        proxmoxOverlay = proxmox-nixos.overlays.${vars.system};
        minecraftoverlay = nix-minecraft.overlay;
      };
      commonModules = [
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        proxmox-nixos.nixosModules.proxmox-ve
        portainer-on-nixos.nixosModules.portainer
        nix-minecraft.nixosModules.minecraft-servers
        copyparty.nixosModules.default
        jellarr.nixosModules.default
        arion.nixosModules.arion
        authentik-nix.nixosModules.default
        vscode-server.nixosModules.default
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
                users.${vars.username} = import ./config/hm-main.nix;
              };
            }
            ./config/nix-main.nix
          ] ++ commonModules;
        };
      };
    };
}