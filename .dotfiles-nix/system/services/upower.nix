{ config, lib, pkgs, ... }:

{
  services.upower.enable = lib.mkForce true; # for ags needed
}
