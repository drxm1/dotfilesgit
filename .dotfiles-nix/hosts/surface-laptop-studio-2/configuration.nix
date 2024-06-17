# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common-configuration.nix ];

  ##### NOTE: From common-configuration.nix #####
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      ## do not add this: pkgs.xdg-desktop-portal-hyprland  (it is already included)
    ];
    wlr.enable = true; # screen sharing
  };
  ############## but changed ... ################

  fileSystems."/" = {
    # TODO / BUG this is really only for surface laptop
    device = lib.mkDefault "/dev/nvme0n1p3";
    fsType = lib.mkDefault "ext4";
  };
  fileSystems."/boot" = {
    # TODO / BUG this is really only for surface laptop
    device = lib.mkDefault "/dev/nvme0n1p1";
    fsType = lib.mkDefault "vfat";
  };
}
