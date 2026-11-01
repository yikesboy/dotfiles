{ palette, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
          path = "/home/lukas/wallpapers/nous-2.jpg";
          blur_passes = 2;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;

          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;

          outer_color = palette.lock.outer;
          inner_color = palette.lock.inner;
          font_color = palette.lock.text;

          fade_on_empty = false;
          rounding = 20;

          check_color = palette.lock.check;

          placeholder_text = "Password";

          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = palette.lock.text;
          font_size = 35;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = palette.lock.text;
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
