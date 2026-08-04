{ ... }: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "JL";
        email = "115737916+yikesboy@users.noreply.github.com";
      };

      init.defaultBranch = "master";
      pull.rebase = false;
      push.autosuggestion = true;
    };
  };
}
