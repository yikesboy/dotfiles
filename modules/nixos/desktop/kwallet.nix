{ pkgs, ... }:
{
  # Use KWallet across desktop sessions, even if Plasma is disabled later.

  environment.systemPackages = with pkgs.kdePackages; [
    kwallet
    kwalletmanager
  ];

  # Unlock the wallet when logging in through SDDM or a TTY.
  security.pam.services = {
    login.kwallet.enable = true;
    sddm.kwallet.enable = true;
  };

  xdg.portal.extraPortals = [
    pkgs.kdePackages.kwallet
  ];
}
