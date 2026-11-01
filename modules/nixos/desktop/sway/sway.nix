{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  xdg.portal.config.sway."org.freedesktop.impl.portal.Secret" = "kwallet";
}
