{ config, lib, pkgs, ... }:

{
  services.printing.enable = true;

  # Locate printers on network
  services.avahi = {
    enable = true;
    nssmdns4 = true; # previously was called nssmdns;
    openFirewall = true;
  };
}
