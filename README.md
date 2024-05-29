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
mkdir $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>
cp /etc/nixos/hardware-configuration.nix $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>/hardware-configuration.nix
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update && nix-shell '<home-manager>' -A install
```

4. Add a new configuration.nix file to specify custom behaviour of your machine, see for example `$HOME/.dotfiles-nix/hosts/pc-ksteg/configuration.nix`, or just copy that file for now:
``` sh
cp $HOME/.dotfiles-nix/hosts/pc-ksteg/configuration.nix $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>/configuration.nix
```
Then update `flake.nix` (create a new _nixosConfiguration_).

4. Activate the system (must use your configuration name or it will fail, due to the current way we import hardware-configuration.nix).
``` sh
cd $HOME/.dotfiles-nix && sudo-nixos-rebuild switch --flake .#<YOUR-NIXOS-CONFIGURATION-NAME>
cd $HOME/.dotfiles-nix && home-manager switch -b backup --flake .
reboot
```


5. copy SSH keys and git-crypt keys from old machine (same wifi connection):
``` sh
scp -r ~/.domi_keys domi@<NEW_MACHINE_IP>:~/
```
Test the connection:
``` sh
ssh -T git@github.com
```
Iff the connection failed you may need to manually add the ssh keys, for example like this:
``` sh
eval "$(ssh-agent -s)"
ssh-add ~/.domi_keys/github_ssh/id_ed25519
```
Test the git-crypt mechanism:
``` sh
dotfilesgit crypt unlock $HOME/.domi_keys/gitcrypt/private.gpg
cat .dotfiles-nix/.secrets/test.txt
dotfilesgit crypt lock
cat .dotfiles-nix/.secrets/test.txt
```
which should now display something reasonable which is not encrypted, then something encrypted.

If the repo does not work anymore, or anyways since we want ssh, just reset everything like this (does not matter since we are on a fresh nixos installation, and the SSH setup is working now):
``` sh
rm -rf $HOME/.dotfiles.git
git clone --bare git@github.com:dominikrosser/dotfilesgit.git $HOME/.dotfiles.git
dotfilesgit checkout --force
dotfilesgit crypt unlock ~/.domi_keys/gitcrypt/private.gpg
dotfilesgit remote rename origin github
```

6. Test if the old SHA256 keys for each flake is still working:
``` sh
cd $HOME/.dotfiles-nix && sudo nixos-rebuild test --flake .#<YOUR-NIXOS-CONFIGURATION-NAME>
```
If not maybe do some cleanup and try again.

7. Install doom emacs (config already in .doom.d but we need to install doom)
``` sh
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom upgrade
~/.emacs.d/bin/doom sync
```

- TODO: The _nixos-hardware_ stuff is still only for the laptop, make it modular so each device can install it's own drivers.
- TODO: The doom-emacs installation is not fully automatic yet, either include the few commands needed to install or add automations to the nix config.

THIS IS A TEST
