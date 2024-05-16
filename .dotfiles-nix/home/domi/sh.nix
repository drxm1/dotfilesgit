# To be included in home-manager

# ARGS:
{ config, pkgs, ... }:
let
  domi_shell_aliases =
    {
      ls = "ls --color=auto";
      ll = "ls -l --color=auto";
      grep = "grep --color=auto";
      ".." = "cd ..";
      dotfilesgit = "git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME";
    };
in 
# RETURNS:
{

  ### BASH ###
  programs.bash = {
    enable = true;
    shellAliases = domi_shell_aliases;
    enableCompletion = true;
    sessionVariables =
      {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
  ### ### ###

  ### ZSH ###
  # REMOVED: home.file.".zshrc".source = ./dotconfig/.zshrc;
  # If using zsh again make sure to add eval "$(direnv hook zsh)" to zshrc!!!
  ### ### ###

}
