{ config, pkgs, user, lib, inputs, ... }:
{
  config = lib.mkIf config.styley.hyprland.enable {
    home-manager.users.${user} = {
      home.packages = [ pkgs.hyprwm-contrib-packages.grimblast ];
      imports = [ inputs.hyprland.homeManagerModules.default ];

      home = {
        sessionVariables = {
          "XCURSOR_SIZE" = "24";
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        xwayland.hidpi = false;
        extraConfig =
          ''
            # This is an example Hyprland config file.
            #
            # Refer to the wiki for more information.

            #
            # Please note not all available settings / options are set here.
            # For a full list, see the wiki
            #

            # See https://wiki.hyprland.org/Configuring/Monitors/
            ${config.styley.hyprland.displays}

            # See https://wiki.hyprland.org/Configuring/Keywords/ for more

            # Execute your favorite apps at launch
            exec-once = wal -c
            exec-once = swww init && hypr-wallpaper
            exec-once = hypr-colors
            exec-once = waybar
            exec-once = xhost si:localuser:root

            # Source a file (multi-file configs)
            # source = ~/.config/hypr/myColors.conf

            # Some default env vars.
            env = XCURSOR_SIZE,24

            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = us
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =

                follow_mouse = 2

                touchpad {
                    natural_scroll = false
                }

                sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                gaps_in = 5
                gaps_out = 10
                border_size = 2
                layout = dwindle
            }

            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                rounding = 10
                inactive_opacity = 0.95
                blur = true
                blur_size = 3
                blur_passes = 1
                blur_new_optimizations = true

                drop_shadow = true
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = true

                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true # you probably want this
            }

            master {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true
            }

            gestures {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = true
                workspace_swipe_distance = 800
            }

            misc {
                #key_press_enables_dpms = true
            }

            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
            device:epic mouse V1 {
                sensitivity = -0.5
            }

            # Example windowrule v1
            # windowrule = float, ^(kitty)$
            # Example windowrule v2
            # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $mainMod = SUPER

            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind = $mainMod, Q, exec, kitty
            bind = $mainMod, C, killactive,
            bind = $mainMod, M, exit,
            bind = $mainMod, E, exec, dolphin
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, D, exec, rofi -show drun
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, J, togglesplit, # dwindle
            bind = $mainMod, F,fullscreen, 0
            bind = $mainMod_SHIFT, F,fakefullscreen
            bind = $mainMod, G,fullscreen, 1

            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d

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

            # dunst controls
            bind = $mainMod, Z, exec, dunstctl history-pop
            bind = $mainMod, X, exec, dunstctl close-all

            # screenshot control
            bind = $mainMod, S, exec, grimblast --notify copy area

            # sleep control
            bind = $mainMod, L,exec,sleep 1 && hyprctl dispatch dpms off
            bind = $mainMod, K,exec, hyprctl dispatch dpms on && hypr-wallpaper && hypr-colors


          '';
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

    nixpkgs.overlays = [
      (self: super: {
        hyprwm-contrib-packages = inputs.hyprwm-contrib.packages.x86_64-linux;
        hyprland = inputs.hyprland.packages.x86_64-linux;
      })
    ];
  };
}