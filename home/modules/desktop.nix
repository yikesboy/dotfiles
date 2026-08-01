{ pkgs, ... }:
let
  terminalBinding = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/";
  browserBinding = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser/";
in
{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 8;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "orange";
    };

    "org/gnome/shell" = {
      enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" ];
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "brave-browser.desktop"
        "vesktop.desktop"
        "thunderbird.desktop"
        "org.gnome.Nautilus.desktop"
        "spotify.desktop"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      autohide = true;
      dock-fixed = false;
      intellihide = false;
      animate-show-apps = true;
      show-show-apps-button = true;
      show-apps-at-top = false;
      show-favorites = true;
      show-trash = false;
      show-mounts = false;
      click-action = "focus-minimize-or-previews";
      hot-keys = false;
      shortcut = [ ];
      shortcut-text = "";
      app-hotkey-1 = [ ];
      app-hotkey-2 = [ ];
      app-hotkey-3 = [ ];
      app-hotkey-4 = [ ];
      app-hotkey-5 = [ ];
      app-hotkey-6 = [ ];
      app-hotkey-7 = [ ];
      app-hotkey-8 = [ ];
      app-hotkey-9 = [ ];
      app-hotkey-10 = [ ];
      app-shift-hotkey-1 = [ ];
      app-shift-hotkey-2 = [ ];
      app-shift-hotkey-3 = [ ];
      app-shift-hotkey-4 = [ ];
      app-shift-hotkey-5 = [ ];
      app-shift-hotkey-6 = [ ];
      app-shift-hotkey-7 = [ ];
      app-shift-hotkey-8 = [ ];
      app-shift-hotkey-9 = [ ];
      app-shift-hotkey-10 = [ ];
      app-ctrl-hotkey-1 = [ ];
      app-ctrl-hotkey-2 = [ ];
      app-ctrl-hotkey-3 = [ ];
      app-ctrl-hotkey-4 = [ ];
      app-ctrl-hotkey-5 = [ ];
      app-ctrl-hotkey-6 = [ ];
      app-ctrl-hotkey-7 = [ ];
      app-ctrl-hotkey-8 = [ ];
      app-ctrl-hotkey-9 = [ ];
      app-ctrl-hotkey-10 = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        terminalBinding
        browserBinding
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      name = "Launch Ghostty";
      command = "ghostty";
      binding = "<Super>t";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser" = {
      name = "Launch Brave";
      command = "brave";
      binding = "<Super>f";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [
        "<Super>q"
        "<Alt>F4"
      ];
    };
  };
}
