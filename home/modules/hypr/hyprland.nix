{ config, lib, pkgs, ... }:

let cfg = config.my.hyprland;
in {
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      ghostty
      kdePackages.dolphin
      wofi
      brave
      ranger
      hyprpaper
      hyprlock
      hyprshot
      nwg-displays
      waybar
      networkmanagerapplet
      gnome-keyring
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      brightnessctl
      playerctl
      wireplumber
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = "ghostty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";
        "$webbrowser" = "brave";

        monitor = [ ",preferred,auto,2" ];

        env = [ "XCURSOR_SIZE,16" "HYPRCURSOR,16" ];

        exec-once = [
          "nm-applet &"
          "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh"
          "hyprpaper"
          "waybar"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "xdg-desktop-portal-hyprland"
          "xdg-desktop-portal-gtk"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          allow_tearing = false;
          layout = "dwindle";
          resize_on_border = true;
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = { enabled = true; };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = { new_status = "master"; };

        misc = {
          force_default_wallpaper = 0;
          new_window_takes_over_fullscreen = 2;
        };

        input = {
          kb_layout = "de";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad.natural_scroll = false;
        };

        gestures = { gesture = "3, horizontal, workspace"; };

        device = [{
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }];

        bind = [
          "$mainMod SHIFT, E, exit"
          "$mainMod, ESCAPE, exec, hyprlock"
          "SUPER, P, exec, nwg-displays"

          "$mainMod, T, exec, $terminal"
          "$mainMod, Q, killactive"
          "$mainMod, F, exec, $webbrowser"
          "$mainMod, R, exec, $terminal -e ranger"
          "$mainMod, Y, togglefloating"
          "$mainMod SHIFT, S, exec, sh -c 'hyprshot -m region --clipboard-only'"
          "$mainMod, A, exec, $menu"

          "$mainMod, M, fullscreen, 1"
          "$mainMod SHIFT, M, fullscreen, 2"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

        xwayland = { force_zero_scaling = true; };
      };
    };

    xdg.configFile."hypr/hyprland.conf".force = true;
  };
}
