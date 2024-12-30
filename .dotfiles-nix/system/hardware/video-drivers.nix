{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
    "vesa"
    # "intel"
  ];
}
