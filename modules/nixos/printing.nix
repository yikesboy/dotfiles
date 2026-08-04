{ pkgs, ... }:
{
  # enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  # discover network printers advertised through IPP/DNS-SD.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  users.users.lukas.extraGroups = [
    "lp"
    "scanner"
  ];
}
