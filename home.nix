{ ... }: {
  imports = [
    ./packages.nix
    ./services.nix
    ./desktop.nix
    ./xdg.nix
    ./programs/git.nix
    ./programs/ssh.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}

