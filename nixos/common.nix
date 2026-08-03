{
  imports = [
    ./modules/base.nix
    ./modules/networking.nix
    ./modules/tailscale.nix
    ./modules/printing.nix
    ./modules/sound.nix
    ./modules/shell.nix
    ./modules/users/lukas.nix
    ./modules/desktop
  ];
}
