{ config, lib, pkgs, ... }:

{
  # FLATPAK -- for scrivano application download needed
  services.flatpak.enable = true;
}
