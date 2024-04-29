{ pkgs, ... }:

{
  services.dunst.enable = true;
  services.dunst.waylandDisplay = "wayland-1";
  # services.dunst.settings = ...
}
