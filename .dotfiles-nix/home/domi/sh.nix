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
    };
in 
# RETURNS:
{

  ### BASH ###
  programs.bash = {
    enable = true;
    shellAliases = domi_shell_aliases;
    sessionVariables =
      {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
  };
  ### ### ###

  ### ZSH ###
  home.file.".zshrc".source = ./.config/.zshrc; 
  ### ### ###

}
