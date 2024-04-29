{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./themes/gtk.nix
    ./themes/qt.nix
  ];
}

