{
  description = "Home-Server";
  inputs = {
    #############
    ## Nixpkgs ##
    #############

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-personal.url = "git+https://git.lillypond.name/dmoeller/nixpkgs-personal";

    ## Workstations
    workstations.url = "git+https://git.lillypond.name/dmoeller/Nixos_V2";

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

    forgesync.url = "git+https://hack.moontide.ink/helvetica/forgesync";

  };

  outputs =
    {
      ## Nixpkgs
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable,
      nixpkgs-personal,

      ## Workstations
      workstations,

      ## Inputs
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
      forgesync,

      ## ETC
      self,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      modulesFolder = ./modules;
      hostsFolder = ./hosts;

      vars = import ./baseplate/vars.nix;
      fun = import ./baseplate/functions.nix {
        inherit lib;
        inherit modulesFolder;
        inherit hostsFolder;
      };

      imports = {
        commonArgs = {
          inherit inputs vars fun;
          pkgs-stable = import nixpkgs-stable {
            inherit vars;
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-unstable = import nixpkgs-unstable {
            inherit vars;
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-personal = nixpkgs-personal.packages.${system};

          proxmoxOverlay = proxmox-nixos.overlays.${system};
          minecraftoverlay = nix-minecraft.overlay;
        };

        commonNixModules = [
          proxmox-nixos.nixosModules.proxmox-ve
          portainer-on-nixos.nixosModules.portainer
          nix-minecraft.nixosModules.minecraft-servers
          copyparty.nixosModules.default
          jellarr.nixosModules.default
          arion.nixosModules.arion
          authentik-nix.nixosModules.default
          vscode-server.nixosModules.default
          forgesync.nixosModules.default

          ## Core
          ./baseplate/nix-main.nix
          ./secrets/secrets-nix.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];

        commonHmModules = [
          ## Core
          ./baseplate/hm-main.nix
        ];
      };

    in
    {
      sshPublicKey = fun.hostSSHKeys;
      nixosConfigurations = {
        lillypond =
          fun.mkHost imports "lillypond"
            [
              ## Nix Modules
            ]
            [
              ## Hm Modules
            ];
      };
    };
}
