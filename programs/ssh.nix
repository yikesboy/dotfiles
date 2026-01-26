{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      host = "github.com";
      user = "git";
      identitiesOnly = true;
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  services.ssh-agent.enable = true;
}

