{ config, pkgs, user, lib, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/zfs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  home-manager.users.${user} = {

    xsession.windowManager.i3 = {
      config = {
        startup = [
          {
            command = "xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --rate 60 --output HDMI-1 --off";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ${../../modules/desktop/wallpaper/laptop}";
            always = true;
            notification = false;
          }
          {
            command = "wal -c && wal -i ${../../modules/desktop/wallpaper/laptop}";
            always = true;
            notification = false;
          }
        ];
      };
    };

    services.picom = {
      enable = true;

      vSync = true;

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
      };
    };
  };
}
  

 


