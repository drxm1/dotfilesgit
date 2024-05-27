# dotfiles-nix

## Installation
Install it as follows on a fresh nixos installation.

1. Ensure flake support (might be optional)
```
nix-shell -p vim
sudo vim /etc/nixos/configuration.nix
# Add the line: nix.settings.experimental-features = [ "nix-command" "flakes" ];
```
2. clone the necessary files (some dotfiles as well as the nixos flakes)
TODO: Instructions to replicate or copy SSH keys and secret stuff.
```
nix-shell -p git
git clone --bare https://github.com/dominikrosser/dotfilesgit.git $HOME/.dotfiles.git
echo "alias dotfilesgit='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'" >> $HOME/.bashrc
source $HOME/.bashrc
dotfilesgit checkout
```
3. Activate the system
TODO: If one of the SHA256 keys for the programs downloaded from github does not match here, change it temporarily. I don't know why this happens.
```
cd $HOME/.dotfiles-nix && sudo-nixos-rebuild switch --flake .
cd $HOME/.dotfiles-nix && home-manager switch --flake .
```
