{ config, lib, ... }:
let
  cfg = config.my.hyprland;
  hyprConfigDir = "${config.home.homeDirectory}/.config/hypr";
  monitorsConf = "${hyprConfigDir}/monitors.conf";
  monitorsOverrideConf = "${hyprConfigDir}/monitors-override.conf";
in {
  config = lib.mkIf cfg.enable {
    home.activation.hyprMonitorOverrides = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -e ${lib.escapeShellArg monitorsConf} ]; then
        mkdir -p ${lib.escapeShellArg hyprConfigDir}
        : > ${lib.escapeShellArg monitorsConf}
      fi

      if [ ! -e ${lib.escapeShellArg monitorsOverrideConf} ]; then
        mkdir -p ${lib.escapeShellArg hyprConfigDir}
        printf '%s\n' 'source = ~/.config/hypr/monitors.conf' > ${lib.escapeShellArg monitorsOverrideConf}
      fi
    '';

    wayland.windowManager.hyprland = {
      settings.bind = [ "SUPER, P, exec, nwg-displays" ];

      extraConfig = ''
        monitor = eDP-1,preferred,0x0,2
        monitor = ,preferred,auto,2,mirror,eDP-1
        source = ~/.config/hypr/monitors-override.conf
      '';
    };
  };
}
