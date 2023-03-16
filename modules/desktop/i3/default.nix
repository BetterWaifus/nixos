{ config, pkgs, user, lib, host, ... }:
{
  config = lib.mkIf config.styley.i3.enable {

    services.xserver.enable = true;

    environment.pathsToLink = [ "/libexec" ];
    services.xserver.desktopManager.xterm.enable = false;
    services.xserver.windowManager.i3.package = pkgs.i3-gaps;
    services.xserver.displayManager.defaultSession = "none+i3";
    services.xserver.windowManager.i3 = {
      enable = true;
    };

    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

    home-manager.users.${user} = {

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
          terminal = "kitty";
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

          window = {
            border = 0;
            titlebar = false;
          };

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
            "Mod4+Shift+S" = "exec maim -s | xclip -sel clip -t image/png";
            "Mod4+d" = "exec rofi -show drun";
            "XF86MonBrightnessUp" = "exec light -A 10";
            "XF86MonBrightnessDown" = "exec light -U 10";
            "XF86AudioRaiseVolume" = "exec amixer set Master 1%+";
            "XF86AudioLowerVolume" = "exec amixer set Master 1%-";
            "XF86AudioMute" = "exec amixer set Master toggle";
            "Mod4+Shift+X" = "exec bash ~/lock.sh";
            "Mod4+Shift+V" = "exec pavucontrol";
            "Mod4+z" = "exec dunstctl history-pop";
            "Mod4+x" = "exec dunstctl close-all";
          };

          startup = [
            {
              command = "systemctl --user start picom.service";
              always = true;
              notification = false;
            }
            {
              command = "systemctl --user restart polybar.service";
              always = true;
              notification = false;
            }
            {
              command = lib.mkAfter "exec bash ~/lock.sh";
              always = true;
              notification = false;
            }
            {
              command = "exec autotiling -w 1 2 3 4";
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
