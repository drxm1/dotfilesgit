{ config, lib, pkgs, ... }:

{
  users.users.domi = {
    isNormalUser = true;
    description = "domi";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "plugdev" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh; # pkgs.bash;
  };

}
