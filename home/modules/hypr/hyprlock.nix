{ ... }: {
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [{
        monitor = "";
        path = "/home/lukas/Wallpapers/wanderer.jpg";
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      }];

      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      input-field = [{
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;

        dots_size = 0.2;
        dots_spacing = 0.35;
        dots_center = true;

        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = "rgba(242, 243, 244, 0.75)";

        fade_on_empty = false;
        rounding = 20;

        check_color = "rgb(204, 136, 34)";

        placeholder_text =
          ''<i><span foreground="##cdd6f4"> Password </span></i>'';

        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      }];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 35;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 120;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
