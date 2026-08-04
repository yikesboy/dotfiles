{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    shellAliases = {
      cat = "bat";
      gud = "lazygit";
      c = "clear";
      nd = "nix develop -c zsh";
      lzd = "lazydocker";
    };

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
