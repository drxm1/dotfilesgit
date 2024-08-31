{ ... }: {
  programs.git = {
    enable = true;
    userName = "drxm1";
    userEmail = "dominik.rosser@protonmail.ch";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/home/domi/.dotfiles-nix";
    };
  };
}
