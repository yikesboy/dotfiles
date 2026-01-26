{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      addKeysToAgent = "yes";
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      hashKnownHosts = true;
    };

    matchBlocks."github.com" = {
      host = "github.com";
      user = "git";
      identitiesOnly = true;
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  services.ssh-agent.enable = true;
}

