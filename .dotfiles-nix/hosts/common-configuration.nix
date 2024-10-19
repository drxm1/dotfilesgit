# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "sg";

  imports = [
    ../system/packages.nix
    ../system/bootloader.nix
    ../system/users.nix
    ../system/nix.nix
    ../system/shells.nix
    ../system/common-envvars.nix
    ../system/networking.nix

    ../system/themes/sddm-theme.nix

    ../system/hardware/nvidia.nix
    ../system/hardware/opengl.nix
    ../system/hardware/intel-cpu.nix
    ../system/hardware/video-drivers.nix
    ../system/hardware/opencl_compute.nix

    ../system/services/displayManager/sddm.nix
    ../system/services/bluetooth_and_sound.nix
    ../system/services/onedrive.nix
    ../system/services/syncthing.nix
    ../system/services/flatpak.nix
    ../system/services/upower.nix
    ../system/services/udiskie.nix
    ../system/services/udisks2.nix
    ../system/services/thermald.nix
    ../system/services/auto-cpufreq.nix
    ../system/services/printing.nix
    ../system/services/openssh.nix
    ../system/services/iptsd.nix
    ../system/services/preload.nix

    ../system/programs/steam.nix
    ../system/programs/npm.nix
    ../system/programs/hyprland.nix
    ../system/programs/thunar.nix
  ];

  # Enable i2c support and install i2c-tools, load i2c-dev module
  hardware.i2c.enable = true;
  environment.systemPackages = with pkgs; [ i2c-tools ];
  boot.kernelModules = [ "i2c-dev" ];

  services.xserver = { xkb.layout = "ch"; };

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true; # screen sharing
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    # do not add - it is already included in hyprland
    # xdg-desktop-portal-hyprland
  ];

  systemd.user.services.xdg-desktop-portal-hyprland = {
    wantedBy = [ "xdg-desktop-portal.service" ];
    before = [ "xdg-desktop-portal.service" ];
  };

  environment.etc."vimrc".text = ''
    " get rid of maddening mouseclick-moves-cursor behavior
    set mouse=
    set ttymouse=
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nixpkgs.config.allowBroken = true;

  # Extra udev rules for ldger s
  groups.plugdev = { };
  services.udev.extraRules = ''
    # HW.1, Nano
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c|2b7c|3b7c|4b7c", TAG+="uaccess", TAG+="udev-acl"

    # Blue, NanoS, Aramis, HW.2, Nano X, NanoSP, Stax, Ledger Test
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"

    # Same, but with hidraw-based library (instead of libusb)
    KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
  '';
}
