{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty.overrideAttrs (old: {
      # keep dead-key composition local to GTK instead of the wayland input method.
      preFixup = (old.preFixup or "") + ''
        gappsWrapperArgs+=(--set GTK_IM_MODULE simple)
      '';
    });
    settings = {
      command = "${pkgs.nushell}/bin/nu";
      theme = "Catppuccin Mocha";
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}
