{ config, lib, pkgs, inputs, ... }:

{
  # STEAM
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    #platformOptimizations.enable = true;
  };

  # Gamescope
  programs.gamescope.enable = true;
  # NOTE gamescope -e -- %command% could be useful try out
}
