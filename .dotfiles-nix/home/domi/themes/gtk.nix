{ pkgs, ... }:
let
  gruvboxPlus = import ./gtk/gruvbox-plus.nix { inherit pkgs; };
  extraCssGtk34 = ''
    @define-color accent_color #83a598;
    @define-color accent_bg_color mix(#83a598, #282828,0.3);
    @define-color accent_fg_color #d5c4a1;
    @define-color destructive_color #83a598;
    @define-color destructive_bg_color mix(#83a598, #282828,0.3);
    @define-color destructive_fg_color #d5c4a1;
    @define-color success_color #8ff0a4;
    @define-color success_bg_color #26a269;
    @define-color success_fg_color #d5c4a1;
    @define-color warning_color #f8e45c;
    @define-color warning_bg_color #cd9309;
    @define-color warning_fg_color rgba(0, 0, 0, 0.8);
    @define-color error_color #ff7b63;
    @define-color error_bg_color mix(#83a598, #282828,0.3);
    @define-color error_fg_color #d5c4a1;
    @define-color window_bg_color #282828;
    @define-color window_fg_color #d5c4a1;
    @define-color view_bg_color #3c3836;
    @define-color view_fg_color #d5c4a1;
    @define-color headerbar_bg_color mix(#282828,black,0.2);
    @define-color headerbar_fg_color #d5c4a1;
    @define-color headerbar_border_color #d5c4a1;
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
    @define-color card_bg_color rgba(255, 255, 255, 0.08);
    @define-color card_fg_color #d5c4a1;
    @define-color card_shade_color rgba(0, 0, 0, 0.36);
    @define-color dialog_bg_color #665c54;
    @define-color dialog_fg_color #d5c4a1;
    @define-color popover_bg_color #665c54;
    @define-color popover_fg_color #d5c4a1;
    @define-color shade_color rgba(0,0,0,0.36);
    @define-color scrollbar_outline_color rgba(0,0,0,0.5);
    @define-color blue_1 #83a598;
    @define-color blue_2 #83a598;
    @define-color blue_3 #83a598;
    @define-color blue_4 #83a598;
    @define-color blue_5 #83a598;
    @define-color green_1 #b8bb26;
    @define-color green_2 #b8bb26;
    @define-color green_3 #b8bb26;
    @define-color green_4 #b8bb26;
    @define-color green_5 #b8bb26;
    @define-color yellow_1 #fabd2f;
    @define-color yellow_2 #fabd2f;
    @define-color yellow_3 #fabd2f;
    @define-color yellow_4 #fabd2f;
    @define-color yellow_5 #fabd2f;
    @define-color orange_1 #fe8019;
    @define-color orange_2 #fe8019;
    @define-color orange_3 #fe8019;
    @define-color orange_4 #fe8019;
    @define-color orange_5 #fe8019;
    @define-color red_1 #fb4934;
    @define-color red_2 #fb4934;
    @define-color red_3 #fb4934;
    @define-color red_4 #fb4934;
    @define-color red_5 #fb4934;
    @define-color purple_1 #d3869b;
    @define-color purple_2 #d3869b;
    @define-color purple_3 #d3869b;
    @define-color purple_4 #d3869b;
    @define-color purple_5 #d3869b;
    @define-color brown_1 #d65d0e;
    @define-color brown_2 #d65d0e;
    @define-color brown_3 #d65d0e;
    @define-color brown_4 #d65d0e;
    @define-color brown_5 #d65d0e;
    @define-color light_1 #d5c4a1;
    @define-color light_2 #f6f5f4;
    @define-color light_3 #deddda;
    @define-color light_4 #c0bfbc;
    @define-color light_5 #9a9996;
    @define-color dark_1 mix(#282828,white,0.5);
    @define-color dark_2 mix(#282828,white,0.2);
    @define-color dark_3 #282828;
    @define-color dark_4 mix(#282828,black,0.2);
    @define-color dark_5 mix(#282828,black,0.4);
  '';
in {
  gtk.enable = true;

  ### GTK THEME ###
  gtk.theme = {
    package = pkgs.adw-gtk3;
    name = "adw-gtk3";
    #name = "Materia-dark";
    #package = pkgs.materia-theme;
  };
  gtk.gtk4.extraCss = extraCssGtk34;
  gtk.gtk3.extraCss = extraCssGtk34;
  #################

  ### ICON THEME ###
  #gtk.iconTheme = {
  #      package = gruvboxPlus; Gruvbox plus does not provide all icons for us
  #      name = "GruvboxPlus"; in the special touch file explorer whose name I dont know
  #};
  ##################

  ### CURSOR THEME ###
  # regular way
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  # basically same as line above
  home.file.".icons/bibata".source =
    "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";
  # both cases still need to select theme name
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = 24;
  };
  ####################
}
