{ pkgs, ... }: {
  home.packages = with pkgs; [ brightnessctl hyprlock ];
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # dim backlight
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        # keyboard backlight
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }

        # lockscreen
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        # screen off after lockscreen
        {
          timeout = 330;
          on-timeout = "on-timeout = hyprctl dispatch dpms off";
          on-resume = "on-resume = hyprctl dispatch dpms on";
        }

        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
