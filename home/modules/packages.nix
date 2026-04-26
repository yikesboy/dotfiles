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
    rustfmt
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
    btop
    tmux
    file-roller

    # GUI Apps
    brave
    zathura
    spotify
    showtime
    rawtherapee
    thunderbird
    libreoffice-fresh
    kdePackages.kio
    nautilus
    kdePackages.kio-extras
    pavucontrol
    gparted
    steam
    unstable.jetbrains.datagrip
    unstable.jetbrains.idea
    unstable.jetbrains.rust-rover
    vscode
    obs-studio
    vlc

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
