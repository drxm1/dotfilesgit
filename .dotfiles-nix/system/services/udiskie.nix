{ config, lib, pkgs, ... }:

{
  systemd.user.services.udiskie = {
    description = "Automount service using udiskie for user devices";
    after = [ "graphical-session-pre.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie -A -n";
      Restart = "always";
    };
  };
}
