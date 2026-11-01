{ ... }: {
  imports = [
    ./modules/packages.nix
    ./modules/programs
    ./modules/shell.nix
    #./modules/desktop.nix
    ./modules/xdg.nix
    ./modules/sway.nix
    ./modules/hyprlock.nix
    ./modules/hypr/hyprland.nix
    ./modules/hypr/hypridle.nix
    ./modules/hypr/hyprpaper.nix
    ./modules/hypr/monitors.nix
  ];

  _module.args.palette = import ../../palette.nix;

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  my.hyprland.enable = true;
}
