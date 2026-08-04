{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings.command = "${pkgs.nushell}/bin/nu";
  };
}
