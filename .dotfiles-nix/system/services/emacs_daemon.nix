{ config, lib, pkgs, ... }:

{
  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "emacs --daemon";
      Restart = "always";
    };
  };
}
