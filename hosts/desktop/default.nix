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
            command = "xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 0x0 --rotate left --rate 144 --output DP-3 --off --output DP-4 --primary --mode 2560x1440 --pos 1080x240 --rotate normal --rate 165 --output DP-5 --off";
            always = true;
            notification = false;
          }
        ]
      ;
    };
  };
};

 # Enables Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

}
