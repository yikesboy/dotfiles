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
    feh

    # GUI Apps
    brave
    zathura
    spotify
    showtime
    rawtherapee
    thunderbird
    libreoffice-fresh
    kdePackages.kio
    kdePackages.dolphin
    kdePackages.kio-extras
    pavucontrol

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
