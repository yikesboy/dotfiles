{
  nixpkgs.overlays = [
    (final: prev: {
      # Keep Brave's cookie encryption independent of the current desktop environment.
      brave = prev.brave.override {
        commandLineArgs = "--password-store=kwallet6";
      };
    })
  ];
}
