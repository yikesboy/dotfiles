{ ... }: {
  services.hyprpaper = {
    enable = true;

    settings = {
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "/home/lukas/wallpapers/nixos.png";
        }
        {
          monitor = "HDMI-A-1";
          path = "/home/lukas/wallpapers/nixos.png";
        }
      ];

      preload = [ "/home/lukas/wallpapers/nixos.png" ];
    };
  };
}
