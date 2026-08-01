{
  config,
  pkgs,
  nvim,
  ...
}:
let
  nixvim = nvim.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
in
{
  home.packages = with pkgs; [
    # Editors
    vim
    #neovim
    nixvim # custom neovim package yikesboy/nvim

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
    #typescript-language-server
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
    yazi
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
    gnomeExtensions.dash-to-dock
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
    zed-editor-fhs

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
    unstable.noctalia-shell
  ];
}
