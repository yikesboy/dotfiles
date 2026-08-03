{ pkgs, ... }:
{
  # these run only under sway and stop if under any other de/wm
  systemd.user.services = {
    sway-polkit-agent = {
      description = "Polkit authentication agent for Sway";
      wantedBy = [ "sway-session.target" ];
      partOf = [ "sway-session.target" ];
      after = [ "sway-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
      };
    };

    sway-network-manager-applet = {
      description = "NetworkManager applet for Sway";
      wantedBy = [ "sway-session.target" ];
      partOf = [ "sway-session.target" ];
      after = [ "sway-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
        Restart = "on-failure";
      };
    };

    sway-notification-daemon = {
      description = "Mako notification daemon for Sway";
      wantedBy = [ "sway-session.target" ];
      partOf = [ "sway-session.target" ];
      after = [ "sway-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
      };
    };
  };
}
