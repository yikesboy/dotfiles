{ config, lib, pkgs, ... }:
let
  cfg = config.my.hyprland;

  homeMonitorDescription = "ASUSTek COMPUTER INC VG27WQ LCLMDW022576";

  monitorLayout = pkgs.writeShellApplication {
    name = "hypr-monitor-layout";
    runtimeInputs = with pkgs; [ coreutils gnugrep hyprland socat ];

    text = ''
      set -euo pipefail

      home_monitor_description=${lib.escapeShellArg homeMonitorDescription}

      state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/hypr-monitor-layout"
      manual_file="$state_dir/manual"

      is_manual() {
        [ -e "$manual_file" ]
      }

      manual_on() {
        mkdir -p "$state_dir"
        touch "$manual_file"
        echo "hypr-monitor-layout: manual override enabled"
      }

      manual_off() {
        rm -f "$manual_file"
        echo "hypr-monitor-layout: manual override disabled"
        apply_layout
      }

      apply_layout() {
        if is_manual; then
          echo "hypr-monitor-layout: manual override active, skipping"
          return 0
        fi

        if hyprctl monitors all | grep -Fq "description: $home_monitor_description"; then
          echo "hypr-monitor-layout: home monitor detected; using external-only layout"

          hyprctl --batch "\
            keyword monitor desc:$home_monitor_description,2560x1440@120,0x0,2 ; \
            keyword monitor eDP-1,disable"
        else
          echo "hypr-monitor-layout: home monitor not detected; using laptop + mirrored external layout"

          hyprctl --batch "\
            keyword monitor eDP-1,preferred,0x0,2 ; \
            keyword monitor ,preferred,auto,2,mirror,eDP-1"
        fi
      }

      wait_for_socket() {
        if [ -z "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
          echo "HYPRLAND_INSTANCE_SIGNATURE is not set" >&2
          exit 1
        fi

        runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
        socket="$runtime_dir/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

        for _ in $(seq 1 50); do
          if [ -S "$socket" ]; then
            return 0
          fi
          sleep 0.1
        done

        echo "Hyprland event socket not found: $socket" >&2
        exit 1
      }

      watch_layout() {
        wait_for_socket
        apply_layout

        socat -U - "UNIX-CONNECT:$socket" | while IFS= read -r event; do
          case "$event" in
            monitoradded*|monitorremoved*)
              sleep 0.3
              apply_layout
              ;;
          esac
        done
      }

      case "''${1:-watch}" in
        apply)
          apply_layout
          ;;
        watch)
          watch_layout
          ;;
        manual-on)
          manual_on
          ;;
        manual-off)
          manual_off
          ;;
        manual-toggle)
          if is_manual; then
            manual_off
          else
            manual_on
          fi
          ;;
        status)
          if is_manual; then
            echo "manual"
          else
            echo "auto"
          fi
          ;;
        *)
          echo "usage: hypr-monitor-layout [apply|watch|manual-on|manual-off|manual-toggle|status]" >&2
          exit 64
          ;;
      esac
    '';
  };
in {
  config = lib.mkIf cfg.enable {
    home.packages = [ monitorLayout ];

    wayland.windowManager.hyprland.settings = {
      # Safe startup fallback. The real policy is applied by hypr-monitor-layout.
      #
      # Do not put the mirror rule here, otherwise Hyprland can complain about
      # overlapping monitors before the script has applied the final layout.
      monitor = [ "eDP-1,preferred,0x0,2" ",preferred,auto-right,2" ];

      exec-once = [ "hypr-monitor-layout watch" ];

      bind = [
        # Manual display configuration:
        #
        # SUPER+P:
        #   enable manual override and open nwg-displays
        #
        # SUPER+SHIFT+P:
        #   disable manual override and return to automatic monitor policy
        #
        # SUPER+CTRL+P:
        #   apply automatic monitor policy once
        "SUPER, P, exec, hypr-monitor-layout manual-on && nwg-displays"
        "SUPER SHIFT, P, exec, hypr-monitor-layout manual-off"
        "SUPER CTRL, P, exec, hypr-monitor-layout apply"
      ];
    };
  };
}

