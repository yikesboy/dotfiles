{ pkgs, ... }: {
  services.hypridle = {
    enable = true;

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

    preload = "/home/lukas/wallpapers/nixos.png";
  };
}
