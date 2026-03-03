{ ... }: {
  imports = [
    ./modules/packages.nix
    ./modules/desktop.nix
    ./modules/xdg.nix
    ./modules/programs/git.nix
    ./modules/programs/ssh.nix
    ./modules/hypr/hyprland.nix
    ./modules/hypr/hypridle.nix
    ./modules/hypr/hyprpaper.nix
    ./modules/hypr/hyprlock.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  my.hyprland.enable = true;
}

