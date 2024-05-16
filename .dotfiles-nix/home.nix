{ config, lib, pkgs, inputs, ... }:

let
  username = "domi";
  system = "x86_64-linux";
  home_dir = "/home/${username}";
  #tree-sitter-nix = inputs.tree-sitter-nix-flake.packages.${system}.tree-sitter-nix;
in {
  home.username = username;
  home.homeDirectory = home_dir;
  home.stateVersion = "23.11"; # DO NOT CHANGE THIS
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./home/${username}/sh.nix
    #./home/${username}/anyrun.nix
    ./home/${username}/git.nix
    ./home/${username}/eww.nix
    ./home/${username}/ags.nix
    ./home/${username}/theming.nix
    ./home/${username}/dunst.nix
    ./home/${username}/hyprland.nix
    ./home/${username}/pkglist.nix
    ./home/${username}/session-variables.nix
    inputs.ags.homeManagerModules.default
  ];

  home.activation.createConfigLink =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sfn /home/domi/.dotfiles-nix/home/domi/dotconfig/eww $HOME/.config/eww
    ''; # Create a (for some reason readonly) symbolic link. for some reason also not editable here...

  # TODO: Create the other symbolic links.

  programs.gpg = { enable = true; };
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Direnv and Lorri
  # TODO: enable direnv as well...
  # run 'lorri init' in the project roots
  services.lorri.enable = true;

}
