{ lib, pkgs, ... }:
let
  modifier = "Mod4";
in
{
  programs.fuzzel.enable = true;
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
      };

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
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      window = {
        border = 2;
        titlebar = false;
      };

      colors = {
        focused = {
          border = "#ffffff";
          background = "#ffffff";
          text = "#ffffff";
          indicator = "#ffffff";
          childBorder = "#ffffff";
        };

        unfocused = {
          border = "#666666";
          background = "#666666";
          text = "#666666";
          indicator = "#666666";
          childBorder = "#666666";
        };

        focusedInactive = {
          border = "#666666";
          background = "#666666";
          text = "#666666";
          indicator = "#666666";
          childBorder = "#666666";
        };

        urgent = {
          border = "#ff0000";
          background = "#ff0000";
          text = "#ffffff";
          indicator = "#ff0000";
          childBorder = "#ff0000";
        };
      };
    };

    # Alternate the split direction for newly created windows.
    extraConfig = ''
      for_window [all] split toggle
    '';
  };
}
