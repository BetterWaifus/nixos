{ config, pkgs, user, lib, host, ... }:
{
  config = lib.mkIf config.styley.i3.enable {
    home-manager.users.${user} = lib.mkIf config.styley.picom.enable {
      services.picom = {
        enable = true;
        package = pkgs.picom;

        vSync = false;

        shadow = true;
        shadowOpacity = 0.75;
        shadowOffsets =
          [
            (-7)
            (-7)
          ];

        fade = true;
        fadeSteps = [
          (0.03)
          (0.03)
        ];

        inactiveOpacity = 0.95;
        activeOpacity = 1.0;

        backend = "glx";

        settings = {
          corner-radius = 10;
          rounded-corners-exclude = [
            ("window_type = 'dock'")
            ("window_type = 'desktop'")
          ];

          shadow-radius = 7;

          opacity-rule = [
            "100:name *= 'LimbusCompany'"
            "100:name *= 'Mozilla Firefox'"
          ];
        };
      };
    };
  };
}
