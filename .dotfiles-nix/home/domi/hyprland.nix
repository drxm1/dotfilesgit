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
      # Hyprgrass: Plugin for touch Gestures.
      # TODO: removed temporarily on PC: inputs.hyprgrass.packages.${pkgs.system}.default

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

}
