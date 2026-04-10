{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Editors
    vim
    neovim

    # Languages, Compilers and Toolchains
    gcc
    go
    gopls
    delve
    lua
    stylua
    lua-language-server
    zig
    rustc
    rust-analyzer
    cargo
    python315
    black
    isort
    ruff
    nodejs_24
    nodePackages.typescript-language-server
    pyright
    typst
    javaPackages.compiler.temurin-bin.jre-21
    jdt-language-server
    typescript
    nil
    nixfmt-classic
    alejandra

    # Unix & CLI Utilities
    curl
    lazygit
    lazydocker
    bat
    unzip
    ripgrep
    ranger
    feh
    pkgs.unstable.codex

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
    gparted
    steam
    unstable.jetbrains.datagrip
    unstable.jetbrains.idea
    vscode

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
