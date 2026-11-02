{
  pkgs,
  palette,
  battery-warning,
  ...
}:
let
  dialogTheme =
    critical:
    pkgs.writeTextDir "gtk-4.0/gtk.css" ''
      @define-color window_bg_color #${palette.base};
      @define-color window_fg_color #${palette.text};
      @define-color dialog_bg_color #${palette.base};
      @define-color dialog_fg_color #${palette.text};
      @define-color view_bg_color #${palette.base};
      @define-color view_fg_color #${palette.text};
      @define-color headerbar_bg_color #${palette.base};
      @define-color headerbar_fg_color #${palette.text};
      @define-color accent_bg_color #${palette.mauve};
      @define-color accent_fg_color #${palette.base};
      @define-color accent_color #${palette.mauve};
      @define-color warning_color #${palette.peach};

      window, window.background, .dialog-content {
        background-color: #${palette.base};
        color: #${palette.text};
      }

      window.background {
        border: 2px solid #${if critical then palette.red else palette.mauve};
        border-radius: 10px;
        box-shadow: none;
      }

      window.background:backdrop { border-color: #${palette.surface0}; }
      window > contents, .dialog-content { border-radius: 8px; }

      window image {
        color: #${if critical then palette.red else palette.peach};
        -gtk-icon-size: 64px;
      }

      window button {
        background-image: none;
        background-color: #${if critical then palette.red else palette.mauve};
        color: #${palette.base};
        border: none;
        box-shadow: none;
      }

      window button:hover { background-color: #${palette.blue}; }
      window button:active { background-color: #${palette.peach}; }
      window button:focus-visible { outline-color: #${palette.text}; }
    '';

  batteryWarning = battery-warning.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  systemd.user.services.battery-warning = {
    Unit = {
      Description = "Persistent low-battery warning";
      PartOf = [ "sway-session.target" ];
      After = [ "sway-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${batteryWarning}/bin/battery-warning --zenity ${pkgs.zenity}/bin/zenity --low-theme ${dialogTheme false} --critical-theme ${dialogTheme true} --low-threshold 15 --critical-threshold 5 --rearm-threshold 20";
      Restart = "on-failure";
      RestartSec = "5s";
      Environment = "LC_ALL=C";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };
}
