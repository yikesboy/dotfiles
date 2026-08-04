{ ... }:
{
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  users.users.lukas.extraGroups = [ "networkmanager" ];
}
