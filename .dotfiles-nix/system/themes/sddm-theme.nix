{ pkgs, ... }:

{
  services.displayManager.sddm.theme = "${import ./sddm/sddm-sugar-dark.nix {inherit pkgs; }}";
}
