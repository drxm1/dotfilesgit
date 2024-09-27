{ config, pkgs, ... }:

{
  # Ensure rsync is available
  environment.systemPackages = [ pkgs.rsync ];

  # Define the systemd service
  systemd.services.sync-xournalpp = {
    description = "Sync XournalPP config to OneDrive";
    script = ''
      ${pkgs.rsync}/bin/rsync -av --delete /home/domi/.config/xournalpp/ /home/domi/OneDrive/xournalpp_backup/
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "domi";
    };
  };

  # Define the systemd timer
  systemd.timers.sync-xournalpp = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
  };
}
