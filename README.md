# dotfiles-nix

## Installation
Install it as follows on a fresh NixOS installation.

### 1. Temporarily enable `git` and `vim`, and ensure flake support:
```sh
nix-shell -p vim git --experimental-features 'nix-command flakes'
```

### 2. Clone dotfiles:
```sh
git clone --bare https://github.com/dominikrosser/dotfilesgit.git $HOME/.dotfiles.git
echo "alias dotfilesgit='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'" >> $HOME/.bashrc
source $HOME/.bashrc && dotfilesgit checkout
```

### 3. Copy your `hardware-configuration.nix` and bootstrap the first home-manager generation:
```sh
mkdir -p $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>
cp /etc/nixos/hardware-configuration.nix $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>/hardware-configuration.nix
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update && nix-shell '<home-manager>' -A install
```

### 4. Add a new `configuration.nix` file:
Specify custom behavior for your machine, or copy the example:
```sh
cp $HOME/.dotfiles-nix/hosts/pc-ksteg/configuration.nix $HOME/.dotfiles-nix/hosts/<NEW-MACHINE>/configuration.nix
```
Then update `flake.nix` to create a new `nixosConfiguration`.

### 5. Activate the system:
Make sure to use your configuration name or it will fail, due to the current way we import `hardware-configuration.nix`.
```sh
cd $HOME/.dotfiles-nix && sudo nixos-rebuild switch --flake .#<YOUR-NIXOS-CONFIGURATION-NAME>
cd $HOME/.dotfiles-nix && home-manager switch -b backup --flake .
reboot
```

### 6. Copy SSH keys and git-crypt keys from the old machine:
Ensure you are on the same Wi-Fi connection.
```sh
scp -r ~/.domi_keys domi@<NEW_MACHINE_IP>:~/
```
Test the connection:
```sh
ssh -T git@github.com
```
If the connection fails, you may need to manually add the SSH keys:
```sh
eval "$(ssh-agent -s)"
ssh-add ~/.domi_keys/github_ssh/id_ed25519
```
Test the git-crypt mechanism:
```sh
dotfilesgit crypt unlock $HOME/.domi_keys/gitcrypt/private.gpg
cat .dotfiles-nix/.secrets/test.txt
dotfilesgit crypt lock
cat .dotfiles-nix/.secrets/test.txt
```
This should display something reasonable (not encrypted) and then something encrypted.

If the repository does not work anymore, or if you want SSH, reset everything:
```sh
rm -rf $HOME/.dotfiles.git
git clone --bare git@github.com:dominikrosser/dotfilesgit.git $HOME/.dotfiles.git
dotfilesgit checkout --force
dotfilesgit crypt unlock ~/.domi_keys/gitcrypt/private.gpg
```

### 7. Test if the old SHA256 keys for each flake are still working:
```sh
cd $HOME/.dotfiles-nix && sudo nixos-rebuild test --flake .#<YOUR-NIXOS-CONFIGURATION-NAME>
```
If not, do some cleanup and try again.

### 8. Install Doom Emacs:
The configuration is already in `.doom.d`, but you need to install Doom:
```sh
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom upgrade
~/.emacs.d/bin/doom sync
```
**TODO:** The Doom Emacs installation is not fully automatic yet. Either include the necessary commands to install or add automation to the Nix config.
