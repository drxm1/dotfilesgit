{ config, lib, pkgs, inputs, ... }:

{
  boot.blacklistedKernelModules = ["nouveau"];
  # Enable OpenGL
  hardware.opengl = {
  	enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  # Dont know what I wanted to do there...
  # systemd.services.nvidia-control-devices = {
  #	wantedBy = [ "multi-user.target" ];
  #	serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  # };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:16:0:0";
        # either offload or sync but never both
        offload = {
          enable = false;
          enableOffloadCmd = false;
        };
        sync.enable = true;
      };

    };

    # We could even boot into our on-the-go configuration to save charge...
    specialisation = {
      on-the-go.configuration = {
        system.nixos.tags = ["on-the-go"];
        hardware.nvidia = {
          prime.offload.enable = lib.mkForce true;
          prime.offload.enableOffloadCmd = lib.mkForce true;
          prime.sync.enable = lib.mkForce false;
        };
      };
    };
}
