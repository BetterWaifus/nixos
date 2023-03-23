{
  config,
  pkgs,
  user,
  lib,
  inputs,
  host,
  ...
}: let
  scale-toggle = pkgs.writeShellScriptBin "scale-toggle" ''
    currentscale=$(hyprctl monitors -j | jq -r '.[] | select(.name == "eDP-1") .scale')

    if [ "$currentscale" = 1 ]; then
        hyprctl keyword monitor eDP-1,2560x1440@60,0x0,1.5 && swww kill && swww init
        hypr-wallpaper && hypr-colors && notify-send "Normal Mode" "1.5x 60hz"
    else
        hyprctl keyword monitor eDP-1,2560x1440@165,0x0,1 && swww kill && swww init
        hypr-wallpaper && hypr-colors && notify-send "Gaming Mode" "1x 165hz"
    fi
  '';
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  config = lib.mkIf config.styley.hyprland.enable {
    programs.hyprland = {
      enable = true;

      xwayland = {
        enable = true;
        hidpi = false;
      };
    };

    environment.systemPackages = with pkgs; [
      hyprland.xdg-desktop-portal-hyprland
    ];

    home-manager.users.${user} = {
      home.packages = [pkgs.hyprwm-contrib-packages.grimblast scale-toggle];
      imports = [inputs.hyprland.homeManagerModules.default];

      home = {
        file.".config/hypr/hyprland.conf".text = lib.concatStringsSep "\n" [
          ''
            ${config.styley.hyprland.displays}

            # startup
            exec-once = wal -c
            exec-once = swww init && hypr-wallpaper
            exec-once = hypr-colors
            exec-once = waybar
            exec-once = xhost si:localuser:root

            # environment variables
            env = XCURSOR_SIZE,24

            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = us
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =

                follow_mouse = 1

                touchpad {
                    natural_scroll = false
                }

                sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
                gaps_in = 5
                gaps_out = 10
                border_size = 2
                layout = dwindle
            }

            decoration {
                rounding = 10
                inactive_opacity = 0.92
                fullscreen_opacity = 1.0
                blur = true
                blur_size = 3
                blur_passes = 2
                blur_new_optimizations = true
                multisample_edges = true;

                drop_shadow = true
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = true


                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                pseudotile = true
                preserve_split = true
            }

            master {

                new_is_master = true
            }

            gestures {
                workspace_swipe = true
                workspace_swipe_distance = 800
            }

            misc {
                disable_hyprland_logo = true
            }

            device:epic mouse V1 {
                sensitivity = -0.5
            }

            windowrulev2 = opacity 1.0 override 1.0 override,class:^(firefox)$
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(vlc)$

            $mainMod = SUPER

            # Binds
            bind = $mainMod, Q, exec, kitty
            bind = $mainMod, C, killactive,
            bind = $mainMod, M, exit,
            bind = $mainMod, E, exec, dolphin
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, D, exec, rofi -show drun
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, N, togglesplit, # dwindle
            bind = $mainMod, F,fullscreen, 0
            bind = $mainMod_SHIFT, F,fakefullscreen
            bind = $mainMod, G,fullscreen, 1

            # Move focus with mainMod + arrow keys
            bind = $mainMod, H, movefocus, l
            bind = $mainMod, J, movefocus, d
            bind = $mainMod, K, movefocus, u
            bind = $mainMod, L, movefocus, r

            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            # volume control
            bind = ,XF86AudioLowerVolume,exec, amixer set Master 1%-
            bind = ,XF86AudioMute,exec, amixer set Master toggle
            bind = ,XF86AudioRaiseVolume,exec, amixer set Master 1%+

            # media control
            bind = ,XF86AudioPlay,exec, playerctl play-pause
            bind = ,XF86AudioNext,exec, playerctl next
            bind = ,XF86AudioPrev,exec, playerctl previous

            # brightness control
            bind = ,XF86MonBrightnessUp,exec, exec light -A 10
            bind = ,XF86MonBrightnessDown,exec, exec light -U 10

            # keyboard brightness control ASUS ONLY
            bind = ,XF86KbdBrightnessUp,exec, asusctl -n
            bind = ,XF86KbdBrightnessDown,exec, asusctl -p
            bind = ,XF86Launch3,exec, asusctl led-mode -n

            # dunst controls
            bind = $mainMod, Z, exec, dunstctl history-pop
            bind = $mainMod, X, exec, dunstctl close-all

            # screenshot control
            bind = $mainMod, S, exec, grimblast --notify copy area

            # sleep control
            bind = $mainMod_SHIFT, L,exec, sleep 1 && hyprctl dispatch dpms off
            bind = $mainMod_SHIFT, K,exec, hyprctl dispatch dpms on && hypr-wallpaper && hypr-colors

            # laptop lid switch sleep
            bindl=,switch:on:Lid Switch,exec,exec, sleep 1 && hyprctl dispatch dpms off
            bindl=,switch:off:Lid Switch,exec,exec, hyprctl dispatch dpms on && hypr-wallpaper && hypr-colors

            +
          ''
          (lib.optionalString (host == "g15") ''
            # scaling toggle
            bind = ,XF86Launch1,exec, scale-toggle

            # set brightness on startup
            exec-once = light -S 80

            # start ROG-Control-Center
            exec-once = rog-control-center
          '')
        ];
      };
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";

        initial_session = {
          command = "Hyprland";
          inherit user;
        };
      };
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    nixpkgs.overlays = [
      (self: super: {
        hyprwm-contrib-packages = inputs.hyprwm-contrib.packages.x86_64-linux;
        hyprland = inputs.hyprland.packages.x86_64-linux;
      })
    ];
  };
}
