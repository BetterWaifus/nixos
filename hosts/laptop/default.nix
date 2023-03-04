{ config, pkgs, user, lib, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/zfs.nix
    ./picom.nix
  ];

  boot.loader = {
    # systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      version = 2;
    };
  };

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
  };
}
  

 


