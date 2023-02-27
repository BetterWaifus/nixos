{ config, pkgs, user, ... }:
{
  config = {
    # enable gnome-keyring for all users
    services.gnome.gnome-keyring.enable = true;

    # enable polkit
    # https://nixos.wiki/wiki/Polkit
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    home-manager.users.${user} = {
      home.packages = with pkgs;
        [
          gcr # stops errors with copilot login?
        ];

    };

    # persist keyring and misc other secrets
    styley.persist.home.directories = [
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".pki"; mode = "0700"; }
      { directory = ".ssh"; mode = "0600"; }
      ".local/share/keyrings"
    ];
  };
}
