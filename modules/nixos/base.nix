{ pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Europe/Vienna";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
    useXkbConfig = false; # use xkb.options in tty.
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts._0xproto
      font-awesome
    ];
  };
}
