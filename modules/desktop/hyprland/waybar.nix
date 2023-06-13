{
  pkgs,
  user,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.styley.hyprland.enable {
    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        package = pkgs.hyprland.waybar-hyprland;
        settings = [
          {
            height = 2;
            margin = "0 0 0 0";
            layer = "top";
            position = "top";
            tray = {spacing = 10;};
            modules-center = [];
            modules-left = ["wlr/workspaces" "hyprland/window"];
            modules-right = [
              "network"
              "pulseaudio"
              "backlight"
              "battery"
              "clock"
              "tray"
            ];
            battery = {
              format = "{icon}  {capacity}%";
              format-charging = "  {capacity}%";
              format-icons = ["" "" "" "" ""];
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
              tooltip = false;
            };
            cpu = {
              format = "{usage}% ";
              tooltip = false;
            };
            memory = {format = "{}% ";};
            backlight = {
              format = "{icon}  {percent}%";
              format-icons = ["󰃞" "󰃟" "󰃝" ""];
              on-scroll-up = "light -A 10";
              on-scroll-down = "light -U 10";
            };
            network = {
              interval = 1;
              format-alt = "{ifname}: {ipaddr}/{cidr}";
              format-disconnected = "Disconnected ⚠";
              format-ethernet = "";
              format-linked = "{ifname} (No IP) ";
              format-wifi = "{essid} ({signalStrength}%) ";
              tooltip = false;
            };
            pulseaudio = {
              format = "{icon}  {volume}%";
              scroll-step = 1;
              format-muted = "婢 Muted";
              format-icons = ["" "" ""];
              on-click-right = "pavucontrol";
              tooltip = false;
            };
          }
        ];
        style = ''
          #waybar {
             background: rgba(0, 0, 0, 0.15);
           }
          #workspaces, #workspaces button, #battery, #backlight, #network, #clock, #pulseaudio, #window, #backlight, #tray {
             font-family: "Inter", "FontAwesome6Free";
             font-weight: bold;
             border-radius: 0;
             transition: none;
             padding: 0 2px;
           }
          #clock, #workspaces button.active {
            margin-right: 4px;
          }
          #backlight, #pulseaudio, #network, #battery, #tray {
            padding: 0 6;
          }
        '';
      };
    };
  };
}
