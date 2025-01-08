{ config, inputs, pkgs, domiHomeOptions, ... }: {

  wayland.windowManager.hyprland = {

    enable = true;

    xwayland.enable = true;

    # define additional content for putting in hyprland.conf
    extraConfig = pkgs.lib.mkDefault ''
      $no_action = notify-send "Hello"
    '';

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      # This defines the content (imports) of hyprland.conf
      # We just import hyprland_domi.conf
      # The rest is handled with just regular git repo sync of .config/hypr
      source =
        # Wow this is ultra hacky, still requires us to keep all configs in .config directly.
        "~/.config/hypr/hyprland_domi.conf";
    };

    plugins = [
      # Hyprgrass: Plugin for touch Gestures.
      inputs.hyprgrass.packages.${pkgs.system}.default

      # TODO: Overview Plugin it is maintained but does not seem to work currently
      # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace

      # TODO: Overview Plugin it is maintained but does not seem to work currently
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo

      # TODO: we are seeing if this works TODO: also configure it in hyprland:
      # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces

      # NOT Maintained currently (probably soon dead):
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

  };

  home.file.".config/hypr/hypridle.conf".source =
    if domiHomeOptions.systemType == "laptop" then
      ./hyprland_linked_configs/hypridle-laptop.conf
    else
      ./hyprland_linked_configs/hypridle-pc.conf;

}
