{ ... }:
{
  programs.git = {
    enable = true;
    userName = "dominikrosser";
    userEmail = "dominik.rosser@protonmail.ch";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/home/domi/.dotfiles";
    };
  };
}
