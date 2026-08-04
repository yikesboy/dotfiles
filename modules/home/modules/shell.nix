{ pkgs, ... }:
let
  myAliases = {
    cat = "bat";
    gud = "lazygit";
    c = "clear";
    lzd = "lazydocker";
  };
in
{
  programs.nushell = {
    enable = true;

    settings.show_banner = false;
    shellAliases = myAliases // {
      nd = "nix develop --command nu";
    };
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    shellAliases = myAliases // {
      nd = "nix develop --command zsh";
    };

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

    icons = "auto";
    git = true;

    extraOptions = [
      "--group-directories-first"
    ];
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      format = "$directory$git_branch$character";
    };
  };
}
