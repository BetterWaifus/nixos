{ config, pkgs, user, lib, host, ... }:
{
  imports = [ ./hardware.nix ];

  config = {

    styley = {
      media.enable = false;
      picom.enable = true;
      i3.enable = false;
      hyprland.enable = true;
      hyprland.monitors = {
        monitor1 = "eDP-1";
      };
      hyprland.displays = "
        monitor=${config.styley.hyprland.monitors.monitor1},1366x768@60,0x0,1
        workspace=${config.styley.hyprland.monitors.monitor1},1
        ";
      hyprland.wallpapers = {
        "${config.styley.hyprland.monitors.monitor1}" = "${../../modules/desktop/wallpaper/aspire/ryoshu-7680x4320.png}";
      };
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";

    services.tlp.enable = true;

    home-manager.users.${user} = {

      xsession.windowManager.i3 = lib.mkIf config.styley.i3.enable {
        config = {
          startup = [
            {
              command = "xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --rate 60 --output HDMI-1 --off";
              always = true;
              notification = false;
            }
            {
              command = "${pkgs.feh}/bin/feh --bg-fill ${../../modules/desktop/wallpaper/aspire}";
              always = true;
              notification = false;
            }
            {
              command = "wal -c && wal -i ${../../modules/desktop/wallpaper/aspire}";
              always = true;
              notification = false;
            }
          ];
        };
      };
    };
  };
}
  

 


