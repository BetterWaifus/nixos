{ config, pkgs, user, lib, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  home-manager.users.${user} = {
    xsession.windowManager.i3 = {
      config = {
        startup = [
          {
            command = "xrandr --output Virtual-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal --output Virtual-2 --off --output Virtual-3 --off --output Virtual-4 --off";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ${../../modules/desktop/wallpaper/vm}";
            always = true;
            notification = false;
          }
          {
            command = "wal -c && wal -i ${../../modules/desktop/wallpaper/vm}";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };
}
