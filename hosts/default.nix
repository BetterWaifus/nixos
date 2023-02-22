{ config, pkgs, user, lib, host, ... }:
{ options.styley.font = lib.mkOption {
   default = "JetBrains Mono"; 
   };
imports = [
    ./configuration.nix
    ./home.nix
  ];
config = {

  home-manager.users.${user} = {

     home.file."wallpaper"={
       source= ../modules/desktop/wallpaper;
       recursive = true;
     };

    services.polybar = {
      script = "polybar";
      enable = true;
    };

    programs.pywal = {
      enable = true;
    };

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        modifier = "Mod4";


        window.border = 0;

        fonts = {
          names = [ config.styley.font ];
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

        bars = lib.mkForce [ ];

        keybindings = lib.mkOptionDefault {
          "Mod4+Shift+S" = "exec maim -s | xclip clipboard -t image/png";
          "Mod4+d" = "exec --no-startup-id rofi -show run";
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";
        };

        extraConfig = {"
          set_from_resource $fg i3wm.color7 #f0f0f0
          set_from_resource $bg i3wm.color2 #f0f0f0

          # class                 border  backgr. text indicator child_border
          client.focused          $bg     $bg     $fg  $bg       $bg
          client.focused_inactive $bg     $bg     $fg  $bg       $bg
          client.unfocused        $bg     $bg     $fg  $bg       $bg
          client.urgent           $bg     $bg     $fg  $bg       $bg
          client.placeholder      $bg     $bg     $fg  $bg       $bg

          client.background       $bg
        "};
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
            command = "wal -c && wal -i ~/wallpaper";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
        ];


      };
    };
  };
};
}