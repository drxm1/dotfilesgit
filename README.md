# dotfiles-nix

## Installation
Install it as follows on a fresh nixos installation.

1. temporarily enable _{git, vim}_ and ensure flake support.
``` sh
nix-shell -p vim git --experimental-features 'nix-command flakes'
```

2. clone dotfiles.
```
git clone --bare https://github.com/dominikrosser/dotfilesgit.git $HOME/.dotfiles.git
echo "alias dotfilesgit='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'" >> $HOME/.bashrc
source $HOME/.bashrc && dotfilesgit checkout
```

3. copy your _hardware-configuration.nix_ and bootstrap the first home-manager generation:
``` sh
cp /etc/nixos/hardware-configuration.nix $HOME/.dotfiles-nix/hardware-configuration.nix
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update && nix-shell '<home-manager>' -A install
```

4. Activate the system
``` sh
cd $HOME/.dotfiles-nix && sudo-nixos-rebuild switch --flake .
cd $HOME/.dotfiles-nix && home-manager switch -b backup --flake .
reboot
```
- TODO: If one of the SHA256 keys for the programs downloaded from github does not match here, change it temporarily. I don't know why this happens.
- TODO: Instructions to replicate or copy SSH keys and secret stuff.
- TODO: The _nixos-hardware_ stuff is still only for the laptop, make it modular so each device can install it's own drivers.
- TODO: The doom-emacs installation is not fully automatic yet, either include the few commands needed to install or add automations to the nix config.
