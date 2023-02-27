{ config, pkgs, user, lib, host, ... }:
{ options.styley.font = lib.mkOption {
   default = "Inter" ; 
   };
  options.styley.monospacefont = lib.mkOption {
    default = "JetBrainsMono Nerd Font" ;
  };
imports = [
    ./configuration.nix
    ./home.nix
  ];
config = {

  home-manager.users.${user} = {

    services.polybar = {
      script = "polybar &";
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
        terminal = "alacritty";
        defaultWorkspace = "workspace number 1";

        workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-4";
        }
        {
          workspace = "2";
          output = "DP-2";
        }
        ];

        window.border = 0;

        fonts = {
          names = [config.styley.font];
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
          "Mod4+Shift+S" = "exec maim -s | xclip -sel clip -t image/png";
          "Mod4+d" = "exec --no-startup-id rofi -show run";
          "XF86MonBrightnessUp" = "exec light -A 10";
          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86AudioRaiseVolume" = "exec amixer set Master 1%+";
          "XF86AudioLowerVolume" = "exec amixer set Master 1%-";
          "XF86AudioMute" = "exec amixer set Master toggle";
        };

        startup = [
          {
            command = "systemctl --user start picom.service";
            always = true;
            notification = false;
          }
          {
            command = lib.mkAfter "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
           {
            command = lib.mkAfter "exec betterdiscordctl -f canary install";
            always = true;
            notification = false;
          }
        ];
      };

      extraConfig = ''
        set_from_resource $fg i3wm.color7 #f0f0f0
        set_from_resource $bg i3wm.color2 #f0f0f0

        # class                 border  backgr. text indicator child_border
        client.focused          $bg     $bg     $fg  $bg       $bg
        client.focused_inactive $bg     $bg     $fg  $bg       $bg
        client.unfocused        $bg     $bg     $fg  $bg       $bg
        client.urgent           $bg     $bg     $fg  $bg       $bg
        client.placeholder      $bg     $bg     $fg  $bg       $bg

        client.background       $bg
        '';
        
    };
  };
};
}