{ config, lib, pkgs, inputs, ... }:

{
  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  programs.xwayland.enable = true;
  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };
  # NOTE some stuff is also managed by home-manager and other stuff via git repo src control!

}
