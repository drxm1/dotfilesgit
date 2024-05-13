{
	description = "My first flake!";

	inputs = 
		{
			nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
			nixos-hardware.url = "github:NixOS/nixos-hardware/master";
			home-manager = {
				url = "github:nix-community/home-manager/master";
				inputs.nixpkgs.follows = "nixpkgs";
			};

      #anyrun.url = "github:Kirottu/anyrun";
      #anyrun.inputs.nixpkgs.follows = "nixpkgs";

			ags.url = "github:Aylur/ags";

      hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";#"github:hyprwm/Hyprland";
      hyprgrass = {
        url = "github:horriblename/hyprgrass";
        inputs.hyprland.follows = "hyprland"; # IMPORTANT
      };
      hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
      };
      pyprland =  {
        url = "github:hyprland-community/pyprland";
      };

		};

	outputs = 
		# TODO: what does this @inputs notation do?
		{ self, nixpkgs, nixos-hardware, home-manager, ags, hyprgrass, hyprland, ... }@inputs:
		let
		  lib = nixpkgs.lib;
		  system = "x86_64-linux";
		  pkgs = nixpkgs.legacyPackages.${system};
		in 	
		{
			nixosConfigurations = {
				nixos = lib.nixosSystem {
					inherit system;
          specialArgs = { inherit inputs; };
					modules = 
						[
							nixos-hardware.nixosModules.microsoft-surface-common
              #./hardware/surface-laptop-studio
              #hyprland.homeManagerModules.default
              ./configuration.nix
						];
				};
			};

			homeConfigurations = {
				domi = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = { inherit inputs; };
					modules = [ ./home.nix ];
				};
			};

			# Domi: "NO CLUE WHAT THIS DOES: I ALSO DONT KNOW IF NEEDED OR NOT..."
			# devShells.${system}.default = pkgs.mkShell {
			#	buildInputs = with pkgs; 
			#		[
			#			cmake
			#			gdb
			#			qt6.qtbase
			#			qt6.full
			#			qtcreator
			#			qt6.wrapQtAppsHook
			#			makeWrapper
			#			bashInteractive
			#		];	
			#	shellHook = ''
			#		export QT_QPA_PLATFORM=wayland
			#		bashdir=$(mktemp -d)
			#		makeWrapper "$(type -p bash" "$bashdir/bash" "''${qtWrapperArgs[@]}"
			#		exec "$bashdir/bash"
			#	'';
			#};

		};

}
