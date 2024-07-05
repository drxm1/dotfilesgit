{ config, inputs, pkgs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # defines additional content for hyprland.conf
    extraConfig = pkgs.lib.mkDefault ''
      $no_action = notify-send "Hello"
    '';
    # sourceFirst = false;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings = {
      # This defines the content (imports) of hyprland.conf
      # We just import hyprland_domi.conf
      # The rest is handled with just regular git repo sync
      source =
        # Wow this is ultra hacky, still requires us to keep all configs in .config directly.
        "~/.config/hypr/hyprland_domi.conf";
    };
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
      inputs.hycov.packages.${pkgs.system}.hycov
    ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

  };

}
