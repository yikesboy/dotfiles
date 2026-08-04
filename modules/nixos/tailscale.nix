{...}:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--ssh=true" ];
  };

  # let networkmanager and tailscale integrate through resolved
  services.resolved.enable = true;
}
