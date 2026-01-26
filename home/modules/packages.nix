{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Editors
    vim
    neovim

    # Languages, Compilers and Toolchains
    gcc
    go
    gopls
    lua
    stylua
    zig
    rustc
    cargo
    python315
    nodejs_24
    pyright
    typst
    javaPackages.compiler.temurin-bin.jre-21
    typescript

    # Unix & CLI Utilities
    curl
    lazygit
    bat
    unzip
    ripgrep
    ranger

    # GUI Apps
    brave
    zathura
    libreoffice-fresh
    showtime
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras

    # Hyprland
    wofi
    waybar
    hypridle
    hyprlock
    hyprshot
    hyprpaper
    nwg-displays
    brightnessctl
    xdg-desktop-portal-hyprland
    upower
    bibata-cursors
    networkmanagerapplet
  ];
}
