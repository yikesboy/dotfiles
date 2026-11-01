{ ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
        HashKnownHosts = true;
      };

      "github.com" = {
        Host = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_ed25519";
      };

      "astra" = {
        Host = "astra";
        User = "lukas";
      };
    };
  };

  services.ssh-agent.enable = true;
}
