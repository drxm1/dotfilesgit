{ inputs, pkgs, system, ... }:

let
  system = "x86_64-linux";
in 
{
  imports = [
    inputs.anyrun.homeManagerModules.default
    #inputs.anyrun.packages.${system}.anyrun-with-all-plugins
    #inputs.anyrun.homeManagerModules.anyrun-with-all-plugins
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/randr"
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/rink"
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/shell"
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/symbols"
        "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/applications"
      ];
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
      .some_class {
        background: red;
      }
    '';

    extraConfigFiles."some-plugin.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
        // refer to docs of xdg.configFile for available options
      )
    '';
  };
  #programs.anyrun = {
  #  enable = true;
  #  config = {
  #    plugins = with inputs.anyrun.packages.${pkgs.system}; [
  #      applications
  #      randr
  #      rink
  #      shell
  #      symbols
  #      anyrun-with-all-plugins
  #    ];
  #    width.fraction = 0.3;
  #    y.absolute = 15;
  #    hidePluginInfo = true;
  #    closeOnClick = true;
  #  };
  #};
}
