{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      command = "${pkgs.nushell}/bin/nu";
      theme = "Catppuccin Mocha";
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}
