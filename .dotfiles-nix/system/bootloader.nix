{ config, lib, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    useOSProber = false;
    efiSupport = true;
    efiInstallAsRemovable = lib.mkDefault false;
    copyKernels = true;
    device = "nodev";
    #extraEntries = ''
    # menuentry "darch" {
    #     set root=(hd0,gpt4)
    #     linux /vmlinuz-linux-surface root=/dev/nvme0n1p5 rw
    #     initrd /initramfs-linux-surface.img
    # }
    #'';
  };
  # Efi loader might not be needed, I don't know
  boot.loader.efi = {
    canTouchEfiVariables = lib.mkDefault true;
    efiSysMountPoint = "/boot";
  };

  # If on a later system we wanted to use zfs encryption
  # https://www.youtube.com/watch?v=CboOUrkIZ2k&list=PLa01scHy0YEnsvjvMNNk-JSvTdL_ivsml&t=1250
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.requestEncryptionCredentials = true;
  # network.hostID = ...
  # services.zfs.autoScrub = true;

  
}
