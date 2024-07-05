{
  description = ".dotfiles-nix flake: Describes the whole linux system.";

  ### INPUTS ###################################################################################
  inputs = {
    # Nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Nix hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Nix home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tree-sitter
    tree-sitter-nix-flake.url = "github:nix-community/tree-sitter-nix";

    # Ags
    ags.url = "github:Aylur/ags";

    # Hyprland
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
      #inputs.hyprland.follows = "hyprland";
    };

  };
  ##############################################################################################

  ### OUTPUTS ##################################################################################
  outputs = { self, nixpkgs, nixos-hardware, home-manager, ags, hyprgrass
    , hyprland, tree-sitter-nix-flake, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      ## NIX CONFIGURATIONS
      nixosConfigurations = {
        ###### Surface Laptop Studio 2 ######
        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixos-hardware.nixosModules.microsoft-surface-common
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-gpu-nvidia
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-hidpi
            ./hosts/surface-laptop-studio-2/configuration.nix
          ];
        };
        #####################################

        ########### PC Ksteg ################
        pc = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/pc-ksteg/configuration.nix ];
        };
        #####################################
      };

      ## HOME CONFIGURATIONS
      homeConfigurations = {
        domi = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };
      };
    };
  ##############################################################################################
}
