{ config, lib, pkgs, ... }:

{
  users.users.domi = {
    isNormalUser = true;
    description = "domi";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "plugdev" "uucp" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh; # pkgs.bash;
  };

}
