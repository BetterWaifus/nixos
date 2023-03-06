{ pkgs, user, config, ... }: {
  config = {
    home-manager.users.${user} = {
      services = {
        dunst = {
          enable = true;
          settings = {
            global = {
              transparency = 15;
              separator_height = 1;
              horizontal_padding = 10;
              frame_width = 0;
              frame_color = "#0B0A0B";
              separator_color = "#f3e8c9";
              font = "${config.styley.font} Regular 12";
              ellipsize = "end";
              show_indicators = "no";
              max_icon_size = 72;
              dmenu = "rofi -p dunst:";
            };
            urgency_low = {
              background = "#0B0A0B";
              foreground = "#f3e8c9";
              timeout = 10;
            };
            urgency_normal = {
              background = "#0B0A0B";
              foreground = "#f3e8c9";
              timeout = 10;
            };
            urgency_critical = {
              background = "#0B0A0B";
              foreground = "#f3e8c9";
              timeout = 0;
            };
            brightness-change = {
              appname = "brightness-change";
              history_ignore = "yes";
            };
            volume-change = {
              appname = "volume-change";
              history_ignore = "yes";
            };
          };
        };
      };
    };
  };
}
