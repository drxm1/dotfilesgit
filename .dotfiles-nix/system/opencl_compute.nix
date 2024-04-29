{ config, lib, pkgs, ... }:

{
  # Could be useful to enable OpenCL compute:
  hardware.opengl.extraPackages = [
    pkgs.intel-compute-runtime
    pkgs.intel-media-driver
  ];
}
