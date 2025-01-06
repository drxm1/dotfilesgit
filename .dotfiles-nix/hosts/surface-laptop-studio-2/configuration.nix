# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common-configuration.nix
    ../../system/services/xournalpp-sync.nix
  ];

  domiOptions.gpu.intelBusId = "PCI:0:2:0";
  domiOptions.gpu.nvidiaBusId = "PCI:243:0:0";

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
  services.iptsd.config = {
    Touchscreen.DisableOnPalm = true;
    Touchscreen.DisableOnStylus = true;
    Stylus.Disable = false;
  };
  users.users.domi.extraGroups = [ "surface-control" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.enable = lib.mkDefault true;

  # Enable some logitech stuff
  # hardware.logitech.wireless.enable = true; # TMP DOMI REMOVE
  # hardware.logitech.lcd.enable = true; # TMP DOMI REMOVE

  # Add packages important for surface device
  environment.systemPackages = with pkgs; [
    surface-control
    libwacom
    xf86_input_wacom
  ];

  # Enable better power management
  services.thermald.enable = lib.mkForce true;
  services.tlp.enable = lib.mkForce true;

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      accelSpeed = "0.8";
      disableWhileTyping = true;
      additionalOptions = ''
        Option "PalmDetection" "on"
        Option "PalmMinWidth" "5"
        Option "PalmMinZ" "50"
      '';
    };
  };
  services.xserver.displayManager.sessionCommands = ''
    xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
  '';
  services.fwupd.enable = true; # fwupdmgr
  services.xserver.wacom.enable = true;
  services.xserver.modules = [ pkgs.xf86_input_wacom ];
}
