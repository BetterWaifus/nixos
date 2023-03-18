{ pkgs, user, lib, host, config, ... }:
{
  config = lib.mkIf config.styley.hyprland.enable {
    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        package = pkgs.hyprland.waybar-hyprland.overrideAttrs (final: prev: {
          src = pkgs.fetchFromGitHub {
            owner = "Alexays";
            repo = "Waybar";
            rev = "473eb0982bc7e0c8f5275079b5c79720d5083711";
            sha256 = "sha256-MRjo3VeeRtNnheaPi+rT4tQwHl9pUMyk1voQ2mzXNMw=";
          };
        });
        settings = [
          ({
            height = 6;
            layer = "top";
            position = "top";
            tray = { spacing = 10; };
            modules-center = [ ];
            modules-left = [ "wlr/workspaces" "hyprland/window" ];
            modules-right = [
              "network"
              "pulseaudio"
              "battery"
              "clock"
              "tray"
            ];
            battery = {
              format = "{icon}  {capacity}%";
              format-charging = "  {capacity}%";
              format-icons = [ "" "" "" "" "" ];
              states = {
                critical = 20;
              };
              tooltip = false;
            };
            "hyprland/window" = {
              separate-outputs = true;
            };
            "wlr/workspaces" = {
              on-click = "activate";
              sort-by-number = true;
            };
            clock = {
              format-alt = "{:%Y-%m-%d}";
              tooltip-format = "{:%Y-%m-%d | %H:%M}";
            };
            cpu = {
              format = "{usage}% ";
              tooltip = false;
            };
            memory = { format = "{}% "; };
            network = {
              format-ethernet = "";
              format-disconnected = "睊  Offline";
              tooltip = false;
            };
            pulseaudio = {
              format = "{icon}  {volume}%";
              scroll-step = 1;
              format-muted = "婢 Muted";
              format-icons = [ "" "" "" ];
              on-click = "pamixer -t";
              on-click-right = "pavucontrol";
              tooltip = false;
            };
          })
        ];
        style = ''
          #waybar {
             background: transparent;
           }
            #workspaces, #workspaces button, #battery, #network, #clock, #pulseaudio, #window, #backlight {
             font-family: "Inter", "FontAwesome6Free";
             font-weight: bold;
             border-radius: 0;
             transition: none;
             padding: 0 2px;
           }
           #clock, #workspaces button.active {
            margin-right: 4px;
          }
          #pulseaudio {
            padding: 0 6;
          }
        '';
      };
    };
  };
}
