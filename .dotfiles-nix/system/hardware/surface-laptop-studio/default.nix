{ nixos-hardware, ... }:
let
  nixoshardwaregit = builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
in 
{
  imports = [
    #nixos-hardware.nixosModules.microsoft-surface-common
    #"${nixoshardwaregit}/common/cpu/intel"
    #"${nixoshardwaregit}/common/gpu/nvidia"
    #"${nixoshardwaregit}/common/gpu/intel"
    #"${nixoshardwaregit}/common/pc"
    #"${nixoshardwaregit}/common/pc/ssd"
    #"${nixoshardwaregit}/common/hidpi.nix"
  ]; 

  microsoft-surface.ipts.enable = true;
  microsoft-surface.surface-control.enable = true;
}
