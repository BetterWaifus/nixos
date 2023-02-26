{ config, pkgs, user, lib, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/zfs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.initrd.postDeviceCommands = lib.mkAfter "zfs rollback -r zroot/local/root@blank";

  home-manager.users.${user} = {
    xsession.windowManager.i3 = {
      config = {
        startup = [
          {
            command = "xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 0x0 --rotate left --rate 144 --output DP-3 --off --output DP-4 --primary --mode 2560x1440 --pos 1080x240 --rotate normal --rate 165 --output DP-5 --off";
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
        ]
      ;
    };
  };

  services.picom = {
      enable = true;

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
      };
     };
     
};

 # Enables Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

}
