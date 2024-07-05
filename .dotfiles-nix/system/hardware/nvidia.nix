{ config, lib, pkgs, ... }:

let domiCfg = config.domiOptions;
in {
  options.domiOptions.gpu = {
    intelBusId = lib.mkOption {
      type = lib.types.str;
      example = "PCI:0:2:0";
      description = "The BusID of the Intel GPU";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      example = "PCI:1:0:0";
      description = "The BusID of the NVIDIA GPU";
    };
  };

  config = {
    boot.blacklistedKernelModules = [ "nouveau" ];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        intelBusId = domiCfg.gpu.intelBusId;
        nvidiaBusId = domiCfg.gpu.nvidiaBusId;
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
        system.nixos.tags = [ "on-the-go" ];
        hardware.nvidia = {
          prime.offload.enable = lib.mkForce true;
          prime.offload.enableOffloadCmd = lib.mkForce true;
          prime.sync.enable = lib.mkForce false;
        };
      };
    };

    # Make sure the options are defined
    assertions = [
      {
        assertion = domiCfg.gpu.intelBusId != "";
        message = "myHardware.nvidia.intelBusId must be defined";
      }
      {
        assertion = domiCfg.gpu.nvidiaBusId != "";
        message = "myHardware.nvidia.nvidiaBusId must be defined";
      }
    ];
  };
}
