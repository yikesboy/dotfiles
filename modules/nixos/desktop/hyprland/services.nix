{ pkgs, ... }:
{
  systemd.user.services.hyprland-polkit-agent = {
    description = "Polkit authentication agent for Hyprland";
    wantedBy = [ "hyprland-session.target" ];
    partOf = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
    };
  };
}
