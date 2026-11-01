{ palette, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      font = "0xProto Nerd Font 10";
      background-color = "#${palette.base}";
      text-color = "#${palette.text}";
      border-color = "#${palette.mauve}";
      progress-color = "over #${palette.surface0}";
      border-size = 2;
      border-radius = 10;
      width = 360;
      height = 180;
      margin = 12;
      padding = 14;
      anchor = "top-right";
      max-visible = 4;
      max-icon-size = 48;
      default-timeout = 10000;
      ignore-timeout = true;
      format = "<b>%s</b>\\n%b";

      "urgency=low".border-color = "#${palette.overlay0}";
      "urgency=critical".border-color = "#${palette.red}";
    };
  };
}
