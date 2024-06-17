{ config, lib, pkgs, ... }:

{
  # SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.settings.General.LogLevel = "debug";
  services.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
  '';
  services.xserver.enable = true;
  security.polkit.enable = true;
  security.pam.services.login = { # sddm = {
    kwallet.enable = true;
    enableKwallet = true;
    kwallet.package = pkgs.kdePackages.kwallet-pam;
  };
}
