{ config, lib, pkgs, ... }:

{
  # Enable OpenGL / Graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
