{ ... }: {
  imports = [
    ./modules/packages.nix
    ./modules/services.nix
    ./modules/desktop.nix
    ./modules/xdg.nix
    ./modules/programs/git.nix
    ./modules/programs/ssh.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}

