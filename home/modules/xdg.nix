{ config, lib, ... }:
let
  apps = {
    browser = "brave-browser.desktop";
    discord = "vesktop.desktop";
    mail = "thunderbird.desktop";

    fileManager = "org.gnome.Nautilus.desktop";
    editor = "nvim.desktop";

    documentViewer = "org.pwmt.zathura.desktop";
    officeWriter = "writer.desktop";
    officeCalc = "calc.desktop";
    officeImpress = "impress.desktop";

    imageViewer = "feh.desktop";
    rawImageViewer = "rawtherapee.desktop";

    videoPlayer = "org.gnome.Showtime.desktop";
    audioPlayer = "vlc.desktop";

    archiveManager = "org.gnome.FileRoller.desktop";
  };

  associations = {
    ${apps.browser} = [
      "text/html"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];

    ${apps.discord} = [ "x-scheme-handler/discord" ];

    ${apps.mail} = [ "x-scheme-handler/mailto" ];

    ${apps.fileManager} =
      [ "inode/directory" "application/x-gnome-saved-search" ];

    ${apps.editor} = [
      "text/plain"
      "text/markdown"
      "text/x-python"
      "text/x-c"
      "text/x-c++"
      "text/x-go"
      "text/x-rust"
      "application/json"
      "application/x-yaml"
      "text/yaml"
      "application/toml"
      "application/xml"
    ];

    ${apps.documentViewer} =
      [ "application/pdf" "application/postscript" "application/epub+zip" ];

    ${apps.officeWriter} = [
      "application/vnd.oasis.opendocument.text"
      "application/msword"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ];

    ${apps.officeCalc} = [
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.ms-excel"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ];

    ${apps.officeImpress} = [
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.ms-powerpoint"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ];

    ${apps.imageViewer} = [
      "image/png"
      "image/jpeg"
      "image/jpg"
      "image/gif"
      "image/webp"
      "image/bmp"
    ];

    ${apps.rawImageViewer} = [ "image/tiff" "image/x-sony-arw" ];

    ${apps.videoPlayer} = [
      "video/mp4"
      "video/x-matroska"
      "video/webm"
      "video/x-msvideo"
      "video/quicktime"
    ];

    ${apps.audioPlayer} = [
      "audio/mpeg"
      "audio/flac"
      "audio/wav"
      "audio/ogg"
      "audio/aac"
      "audio/mp4"
      "audio/x-matroska"
      "audio/x-opus+ogg"
    ];

    ${apps.archiveManager} = [
      "application/zip"
      "application/x-tar"
      "application/gzip"
      "application/x-compressed-tar"
      "application/x-7z-compressed"
      "application/x-rar"
    ];
  };

  mkDefaultApplications = lib.concatMapAttrs
    (desktopFile: mimeTypes: lib.genAttrs mimeTypes (_: [ desktopFile ]))
    associations;
in {
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = mkDefaultApplications;
    };

    configFile = {
      "mimeapps.list".force = true;

      "ghostty/config" = {
        force = true;
        text = ''
          theme = Catppuccin Mocha
        '';
      };
    };

    dataFile."applications/mimeapps.list".force = true;
  };
}

