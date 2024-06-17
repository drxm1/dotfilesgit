{ config, lib, pkgs, ... }:

{
  # Shells
  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  #users.defaultUserShell = pkgs.bash;
  programs.zsh.enable = true;
}
