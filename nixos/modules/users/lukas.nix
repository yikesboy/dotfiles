{ pkgs, ... }:
{
  users.users.lukas = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "dialout"
    ];
  };
}
