{ config, lib, pkgs, inputs, ... }:

{
  # TODO: for some reason the service is not working at the moment, fix that.
  services.onedrive.enable = true;
}
