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
      format = "$username$hostname$directory$git_branch$custom$character";

      username = {
        show_always = true;
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style) ";
      };

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
      };

      git_branch = {
        symbol = "";
        format = "[git:\\(](bold blue)[$branch](red)[\\)](bold blue) ";
      };

      custom.git_dirty = {
        command = "printf ✗";
        when = "git status --porcelain | grep -q .";
        format = "[$output](bold yellow) ";
      };
    };
  };
}
