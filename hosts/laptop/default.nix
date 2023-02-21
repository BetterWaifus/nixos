{ config, pkgs, user, lib, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  home-manager.users.${user} = {
    services.picom = {
      enable = true;

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
