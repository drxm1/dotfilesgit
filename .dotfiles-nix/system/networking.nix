{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable iwd (Wireless daemon for Linux)
  networking.wireless.iwd = {
    enable = true;
    settings = { General = { EnableNetworkConfiguration = true; }; };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

}
