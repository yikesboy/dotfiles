{ ... }: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      preload = [ "/home/lukas/wallpapers/nixos.png" ];

      wallpaper = [
        "eDP-1,/home/lukas/wallpapers/nixos.png"
        "HDMI-A-1,/home/lukas/wallpapers/nixos.png"
      ];
    };
  };
}
