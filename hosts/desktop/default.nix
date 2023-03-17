{ config, pkgs, user, lib, host, ... }:
{
  imports = [ ./hardware.nix ];

  config = {

    styley = {
      media.enable = true;
      picom.enable = true;
      i3.enable = false;
      hyprland.enable = true;
      hyprland.monitor = {
        monitor1 = "DP-2";
        monitor2 = "DP-3";
      };
      hyprland.displays = " 
        monitor=${config.styley.hyprland.monitors.monitor1},2560x1440@165,1080x198,1
        workspace=${config.styley.hyprland.monitors.monitor1},2
        monitor=${config.styley.hyprland.monitors.monitor2},1920x1080@144,0x0,1
        workspace=${config.styley.hyprland.monitors.monitor2},1
        monitor=${config.styley.hyprland.monitors.monitor2},transform,1 # rotate monitor
        ";
      hyprland.wallpapers = {
        "${config.styley.hyprland.monitors.monitor1}" = "${../../modules/desktop/wallpaper/desktop/ellowas-widow-5040x2160.jpg}";
        "${config.styley.hyprland.monitors.monitor2}" = "${../../modules/desktop/wallpaper/desktop/ellowas-widow-5040x2160.jpg}";
      };
    };

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

      xsession.windowManager.i3 = lib.mkIf config.styley.i3.enable {
        config = {
          assigns = {
            "1" = [{ class = "^firefox$"; } { class = "^discord$"; }];
          };
          startup = [
            {
              command = "xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --primary --mode 2560x1440 --pos 1080x198 --rotate normal --rate 165 --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 0x0 --rotate left --rate 144 --output DP-5 --off --output USB-C-0 --off";
              always = true;
              notification = false;
            }
            {
              command = "${pkgs.feh}/bin/feh --bg-fill ${../../modules/desktop/wallpaper/desktop}";
              always = true;
              notification = false;
            }
            {
              command = "wal -c && wal -i ${../../modules/desktop/wallpaper/desktop}";
              always = true;
              notification = false;
            }
            {
              command = lib.mkAfter "exec firefox";
              always = true;
              notification = false;
            }
            {
              command = lib.mkAfter "exec discord";
              always = true;
              notification = false;
            }
          ];
        };
      };
    };

    # Enables Nvidia drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;

  };
}
