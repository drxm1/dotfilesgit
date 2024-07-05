# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:
let
  #nixoshardwaregit =
  #  builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
in {
  imports = [ ./hardware-configuration.nix ../common-configuration.nix ];

  fileSystems."/" = {
    device = lib.mkDefault "/dev/nvme0n1p3";
    fsType = lib.mkDefault "ext4";
  };
  fileSystems."/boot" = {
    device = lib.mkDefault "/dev/nvme0n1p1";
    fsType = lib.mkDefault "vfat";
  };

  # Enable IPTSD for better touchscreen and stylus support
  services.iptsd.enable = true;

  # Add packages important for surface device
  environment.systemPackages = with pkgs; [
    surface-control
    libwacom
    xf86_input_wacom
  ];

  # Improve touchpad responsiveness
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    touchpad.accelSpeed = "0.8";
  };

}
