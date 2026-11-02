{
  config,
  lib,
  pkgs,
  palette,
  ...
}:
let
  modifier = "Mod4";
  nerdIcon = code: builtins.fromJSON ''"\u${code}"'';
in
{
  programs.fuzzel.enable = true;

  programs.i3status-rust = {
    enable = true;
    bars.default = {
      settings = {
        icons = {
          icons = "none";
          overrides = {
            net_wireless = builtins.fromJSON ''
              ["\udb82\udd1f", "\udb82\udd22", "\udb82\udd25", "\udb82\udd28"]
            '';
            net_wired = nerdIcon "f0e8";
            net_vpn = nerdIcon "f023";
            net_loopback = nerdIcon "f0e2";
            bat = nerdIcon "f240";
            bat_charging = nerdIcon "f0e7";
            bat_not_available = nerdIcon "f128";
            disk_drive = nerdIcon "f0a0";
            cpu = nerdIcon "f2db";
            memory_mem = nerdIcon "efc5";
            time = nerdIcon "f017";
            volume = [
              (nerdIcon "f026")
              (nerdIcon "f027")
              (nerdIcon "f028")
            ];
            volume_muted = nerdIcon "f6a9";
            microphone = nerdIcon "f130";
            xrandr = nerdIcon "f108";
            webcam = nerdIcon "f030";
            unknown = nerdIcon "f128";
            music = nerdIcon "f001";
            music_prev = nerdIcon "f048";
            music_play = nerdIcon "f04b";
            music_pause = nerdIcon "f04c";
            music_next = nerdIcon "f051";
            bluetooth = nerdIcon "f293";
            keyboard = nerdIcon "f11c";
          };
        };
        theme = {
          theme = "plain";
          overrides = {
            idle_bg = "#${palette.base}";
            info_bg = "#${palette.base}";
            good_bg = "#${palette.base}";
            warning_bg = "#${palette.base}";
            critical_bg = "#${palette.base}";
            idle_fg = "#${palette.text}";
            info_fg = "#${palette.blue}";
            good_fg = "#${palette.text}";
            warning_fg = "#${palette.peach}";
            critical_fg = "#${palette.red}";
            alternating_tint_bg = "#00000000";
            alternating_tint_fg = "#00000000";
            separator = "|";
            separator_bg = "#${palette.base}";
            separator_fg = "#${palette.overlay0}";
          };
        };
      };
      blocks = [
        {
          block = "privacy";
          driver = [
            { name = "pipewire"; }
            { name = "v4l"; }
          ];
          icons_overrides.volume = nerdIcon "f028";
        }
        {
          block = "music";
          format = "{$icon $combo.str(max_w:24) $prev $play $next |}";
        }
        {
          block = "net";
          format = " $icon {$ssid |}{$ip|no IPv4} ";
          inactive_format = " $icon down ";
          missing_format = " net missing ";
        }
        {
          block = "battery";
          driver = "upower";
          device = "DisplayDevice";
          format = " $icon $percentage.eng(w:2,pad_with:''){ $time_remaining.dur(hms:true,min_unit:m)|} ";
          full_format = " $icon $percentage.eng(w:2,pad_with:'') ";
          empty_format = " $icon $percentage.eng(w:2,pad_with:'') ";
          not_charging_format = " $icon $percentage.eng(w:2,pad_with:'') ";
        }
        {
          block = "disk_space";
          path = "/";
          format = " $icon $available.eng(w:3,prefix:Gi,pad_with:'') ";
        }
        {
          block = "cpu";
          format = " $icon $utilization.eng(w:2,pad_with:'') ";
        }
        {
          block = "memory";
          format = " $icon $mem_used.eng(w:3,prefix:Gi,pad_with:'')/$mem_avail.eng(w:3,prefix:Gi,pad_with:'') ";
        }
        {
          block = "bluetooth";
          mac = "D9:4C:E3:ED:50:31";
          disconnected_format = "";
          format = " $icon $name{ $battery_icon $percentage.eng(w:2,pad_with:'')|} ";
        }
        {
          block = "sound";
          driver = "pulseaudio";
          headphones_indicator = false;
          show_volume_when_muted = true;
          format = " $icon $volume.eng(w:2,pad_with:'') ";
        }
        {
          block = "time";
          interval = 1;
          format = " $icon $timestamp.datetime(f:'%Y-%m-%d %H:%M:%S') ";
        }
      ];
    };
  };

  home.packages = [ pkgs.swaybg ];

  services.swayidle = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
    timeouts = [
      {
        timeout = 300;
        command = lib.getExe pkgs.hyprlock;
      }
      {
        timeout = 600;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events.before-sleep = lib.getExe pkgs.hyprlock;
  };

  # keep the session awake during sustained audio playback
  systemd.user.services.wayland-pipewire-idle-inhibit = {
    Unit = {
      Description = "Inhibit idle during PipeWire audio playback";
      PartOf = [ "sway-session.target" ];
      After = [ "sway-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = lib.getExe pkgs.wayland-pipewire-idle-inhibit;
      Restart = "on-failure";
      RestartSec = "2s";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      inherit modifier;

      terminal = lib.getExe pkgs.ghostty;

      input."type:keyboard" = {
        xkb_layout = "de";
      };

      output."*" = {
        scale = "2";
        bg = "/home/lukas/wallpapers/nixos.png fill";
      };

      bars = [
        {
          command = "${pkgs.sway}/bin/swaybar";
          statusCommand = "${lib.getExe config.programs.i3status-rust.package} ${config.xdg.configHome}/i3status-rust/config-default.toml";
          fonts = {
            names = [ "0xProto Nerd Font" ];
            size = 8.0;
          };
          hiddenState = "hide";
          mode = "dock";
          position = "bottom";
          trayOutput = "primary";
          workspaceButtons = true;
          workspaceNumbers = true;

          colors = {
            background = "#${palette.base}";
            statusline = "#${palette.text}";
            separator = "#${palette.overlay0}";

            focusedWorkspace = {
              border = "#${palette.mauve}";
              background = "#${palette.mauve}";
              text = "#${palette.base}";
            };

            activeWorkspace = {
              border = "#${palette.blue}";
              background = "#${palette.blue}";
              text = "#${palette.base}";
            };

            inactiveWorkspace = {
              border = "#${palette.surface0}";
              background = "#${palette.surface0}";
              text = "#${palette.subtext0}";
            };

            urgentWorkspace = {
              border = "#${palette.red}";
              background = "#${palette.red}";
              text = "#${palette.base}";
            };

            bindingMode = {
              border = "#${palette.peach}";
              background = "#${palette.peach}";
              text = "#${palette.base}";
            };
          };
        }
      ];

      startup = [
        {
          command = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
          always = false;
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+q" = "kill";
        "${modifier}+t" = "exec ${lib.getExe pkgs.ghostty}";
        "${modifier}+f" = "exec ${lib.getExe pkgs.brave}";
        "${modifier}+a" = "exec ${lib.getExe pkgs.fuzzel}";
        "${modifier}+m" = "fullscreen toggle";
        "${modifier}+Escape" = "exec ${lib.getExe pkgs.hyprlock}";
        "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set 10%-";
        "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set 10%+";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
      };

      colors = {
        background = "#${palette.base}";
        focused = {
          border = "#${palette.mauve}";
          background = "#${palette.mauve}";
          text = "#${palette.base}";
          indicator = "#${palette.blue}";
          childBorder = "#${palette.mauve}";
        };

        unfocused = {
          border = "#${palette.surface0}";
          background = "#${palette.base}";
          text = "#${palette.subtext0}";
          indicator = "#${palette.surface0}";
          childBorder = "#${palette.surface0}";
        };

        focusedInactive = {
          border = "#${palette.overlay0}";
          background = "#${palette.surface0}";
          text = "#${palette.subtext0}";
          indicator = "#${palette.overlay0}";
          childBorder = "#${palette.overlay0}";
        };

        urgent = {
          border = "#${palette.red}";
          background = "#${palette.red}";
          text = "#${palette.base}";
          indicator = "#${palette.peach}";
          childBorder = "#${palette.red}";
        };
      };
    };

    extraConfig = ''
      # Fibonacci splitting.
      for_window [all] split toggle

      # Keep battery warnings centered and focused without compositor decorations.
      for_window [title="^Battery (Low|Critical)$"] floating enable
      for_window [title="^Battery (Low|Critical)$"] border none
      for_window [title="^Battery (Low|Critical)$"] resize set width 460 px height 220 px
      for_window [title="^Battery (Low|Critical)$"] move position center
      for_window [title="^Battery (Low|Critical)$"] focus
    '';
  };
}
