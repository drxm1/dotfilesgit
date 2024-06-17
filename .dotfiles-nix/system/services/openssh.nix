{ config, lib, pkgs, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # TODO: Setup OpenSSH with keys
  # users.(...).openssh = {}

}
