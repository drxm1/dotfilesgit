{ pkgs, ... }:
{
  programs.ags = {
      enable = true;
      # null or path, leave as null if you dont want hm to manage the config
      configDir = null; # unfortunately it would make it readonly!
      #./home/${username}/.config/ags; 
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
        ollama
        python311Packages.material-color-utilities
        python311Packages.pywayland
        pywal
        sassc
        webkitgtk
        webp-pixbuf-loader
        ydotool
      ];
  };
}
