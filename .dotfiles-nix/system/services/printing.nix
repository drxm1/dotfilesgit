{ config, lib, pkgs, ... }:

{
  services.printing.enable = true;

  # Locate printers on network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
