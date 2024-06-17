{ config, lib, pkgs, ... }:

{
  services.syncthing.enable = true;
  services.syncthing.user = "domi";
}
