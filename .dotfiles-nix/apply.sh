#!/usr/bin/env sh

pushd ~/.dotfiles-nix
sudo nixos-rebuild switch --flake .
echo 'Applied rebuild'
home-manager switch --flake .
echo 'Applied home'
popd
