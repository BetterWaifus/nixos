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
        monitor=${config.styley.hyprland.monitors.monitor1},2560x1440@165,0x0,1
        workspace=${config.styley.hyprland.monitors.monitor1},1
        ";
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

    services.tlp.enable = false;

    home-manager.users.${user} = {

      xsession.windowManager.i3 = lib.mkIf config.styley.i3.enable {
        config = {
          assigns = {
            "1" = [{ class = "^firefox$"; } { class = "^discord$"; }];
          };
          startup = [
            {
              command = "xrandr --output eDP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --rate 165 --output HDMI-1 --off";
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

    # Enables AMD GPU drivers
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.opengl.enable = true;

  };
}
