{ config, lib, pkgs, ... }:

{
  # Enable iptsd (Userspace daemon for Intel Precise Touch & Stylus
  services.iptsd.enable = true;
}
