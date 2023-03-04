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
      extraEntries = lib.concatStringsSep "\n" [
        ''
          menuentry "Windows 10" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root C4EA-88C2
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        ''
      ];
    };
  };

  home-manager.users.${user} = {

    xsession.windowManager.i3 = {
      config = {
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
        ];
      };
    };
  };

  # Enables Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

}
