{ config,lib,pkgs,inputs,...  }:
{
  qt.enable = true; # Enable Qt5 and 6 configuration
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

}
