{ pkgs, ... }: {
  systemd.user.services.hypridle = {
    Unit = {
      Description = "hypridle (idle daemon for hyprland)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
