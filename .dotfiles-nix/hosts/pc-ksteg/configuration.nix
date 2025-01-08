# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common-configuration.nix ];

  domiOptions.gpu.intelBusId = "PCI:99:9:9"; # dont have this here
  domiOptions.gpu.nvidiaBusId = "PCI:01:0:0";
  domiOptions.systemType = "pc";

}
