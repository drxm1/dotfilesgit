# To be included in home-manager

# ARGS:
{ config, pkgs, ... }:
let
  domi_shell_aliases = {
    ls = "ls --color=auto";
    ll = "ls -l --color=auto";
    grep = "grep --color=auto";
    ".." = "cd ..";
    dotfilesgit = "git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME";
  };
  # RETURNS:
in {

  ### BASH ###
  programs.bash = {
    enable = true;
    shellAliases = domi_shell_aliases;
    enableCompletion = true;
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
  ### ### ###

  ### ZSH ###
  # Managing zsh not with nix.
  # We are currently managing it directly in the right place
  ### ### ###

}
