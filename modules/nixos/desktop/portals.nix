{ ... }:
{
  xdg.portal.config = {
    # Prevent legacy fallback to Hyprland's backend in Sway.
    sway."org.freedesktop.impl.portal.GlobalShortcuts" = "none";

    # Preserve Hyprland's defaults alongside our custom KWallet routing.
    hyprland.default = [
      "hyprland"
      "gtk"
    ];
  };
}
