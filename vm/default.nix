{ config, pkgs, user, lib, host, ...}:
{
  imports =[
    (import ./polybar.nix {
      user=user;
      pkgs=pkgs;
      config=config;
      lib=lib;
      host=host;
    })
    
  ];

  home-manager.users.${user} = {

    home.file."wallpaper"={
      source=./wallpaper;
      recursive = true;
    };

    services.polybar = {
      script = "polybar";
      enable = true;
    };

    programs.pywal = {
      enable = true;
    };

    #services.picom = {
    #  enable = true;

     # shadow = true;
      #shadowOpacity = 0.75;
     # shadowOffsets =
     # [
     #   (-7)
     #   (-7)
      #];

     # fade = true;
    #  fadeSteps = [
    #    (0.03)
     #   (0.03)
     # ];

     # inactiveOpacity = 0.95;
     # activeOpacity = 1.0;

     # backend = "glx";

      #settings = {
      #  corner-radius = 10;
      #  shadow-radius = 7;
    #  };
   # };

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      
      config = {
        modifier = "Mod4";


        window.border = 0;

        fonts = {
          names = [ "JetBrains-Mono" ];
          style = "Regular";
          size = 8.0;
        };

        gaps = {
          inner = 5;
          outer = 5;
        };

        floating = {
          modifier = "Mod4";
        };

        bars = lib.mkForce [];
        
        keybindings = lib.mkOptionDefault {
          "Mod4+Shift+S" = "exec maim -s | xclip clipboard -t image/png";
          "Mod4+d" = "exec --no-startup-id rofi -show run";
        };


        startup = [
          {
            command = "xrandr --output Virtual-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal --output Virtual-2 --off --output Virtual-3 --off --output Virtual-4 --off";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user start picom.service";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ~/wallpaper";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          {
            command = "wal -c && wal -i ~/wallpaper";
            always = true;
            notification = false;
          }
        ];


      };
    };
  };
}
