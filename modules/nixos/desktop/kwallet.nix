{ pkgs, ... }:
{
  # shared across non-plasma window-managers

  environment.systemPackages = with pkgs.kdePackages; [
    kwallet
    kwalletmanager
  ];

  security.pam.services.login.kwallet.enable = true;

  xdg.portal.extraPortals = [
    pkgs.kdePackages.kwallet
  ];
}
