{ config, ... }: {
  xdg.configFile."ghostty/config" = {
    force = true;
    text = ''
      theme = Catppuccin Mocha
    '';
  };
}
