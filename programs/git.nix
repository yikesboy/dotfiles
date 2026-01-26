{ ... }: {
  programs.git = {
    enable = true;
    userName = "JL";
    userEmail = "115737916+yikesboy@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = false;
      push.autosuggestion = true;
    };
  };
}
