{ username, ... }:
{
  programs.eww = {
    enable = true;
    # configDir = ./home/${username}/.config/eww;
    configDir = ./.config/eww;
  };
}
