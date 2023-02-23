{ pkgs, host, user, config, ... }: {
  home-manager.users.${user} = {
    services.polybar = {
      enable = true;
      config = {
        colors = {
          background = "\${xrdb:color0:#222}";
          foreground = "\${xrdb:color7:#222}";
          foreground-alt = "\${xrdb:color7:#222}";
          primary = "\${xrdb:color1:#222}";
          secondary = "\${xrdb:color2:#222}";
          alert = "\${xrdb:color3:#222}";
          disabled = "#707880";
        };

        "bar/example" = {
          width = "100%";
          height = "16pt";
          radius = 0;

          # dpi = 96;

          background = "\${colors.background}";
          foreground = "\${colors.foreground}";

          line-size = "3pt";

          border-size = "0pt";
          border-color = "#00000000";

          padding-left = 0;
          padding-right = 1;

          module-margin = 1;

          separator = "|";
          separator-foreground = "\${colors.disabled}";

          font-0 = "${config.styley.font}:pixelsize=12;2";

          modules-left = "xworkspaces xwindow";
          modules-right = "filesystem alsa xkeyboard memory cpu wlan eth battery date";

          cursor-click = "pointer";
          cursor-scroll = "ns-resize";

          enable-ipc = true;

          # tray-position = "right";

          # wm-restack = "generic";
          # wm-restack = "bspwm";
          # wm-restack = "i3";

          # override-redirect = true;
        };

        "module/xworkspaces" = {
          type = "internal/xworkspaces";

          label-active = "%name%";
          label-active-background = "\${colors.background-alt}";
          label-active-underline = "\${colors.primary}";
          label-active-padding = 1;

          label-occupied = "%name%";
          label-occupied-padding = 1;

          label-urgent = "%name%";
          label-urgent-background = "\${colors.alert}";
          label-urgent-padding = 1;

          label-empty = "%name%";
          label-empty-foreground = "\${colors.disabled}";
          label-empty-padding = 1;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:60:...%";
        };

        "module/alsa" = {
          type = "internal/alsa";

          format-volume-prefix = "VOL ";
          format-volume-prefix-foreground = "\${colors.primary}";
          format-volume = "<label-volume>";

          label-volume = "%percentage%%";

          label-muted = "muted";
          label-muted-foreground = "\${colors.disabled}";
        };

        "module/xkeyboard" = {
          type = "internal/xkeyboard";
          blacklist-0 = "num lock";

          label-layout = "%layout%";
          label-layout-foreground = "\${colors.primary}";

          label-indicator-padding = 2;
          label-indicator-margin = 1;
          label-indicator-foreground = "\${colors.background}";
          label-indicator-background = "\${colors.secondary}";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format-prefix = "RAM ";
          format-prefix-foreground = "\${colors.primary}";
          label = "%percentage_used:2%%";
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          format-prefix = "CPU ";
          format-prefix-foreground = "\${colors.primary}";
          label = "%percentage:2%%";
        };

        network-base = {
          type = "internal/network";
          interval = "5";
          format-connected = "<label-connected>";
          format-disconnected = "<label-disconnected>";
          label-disconnected = "%{F#F0C674}%ifname%%{F#707880} disconnected";
        };

        "module/wlan" = {
          "inherit" = "network-base";
          interface-type = "wireless";
          label-connected = "%essid% %local_ip%";
        };

        "module/battery" = {
          type = "internal/battery";
          full-at = 99;
          low-at = 5;
          battery = "BAT1";
          adapter = "ADP1";
          poll-interval = 5;
          format-prefix = "BAT ";
          format-prefix-foreground = "\${colors.primary}";
          format-battery = "<label-battery>";
          label-battery = "%percentage%%";
        };
        
        "module/date" = {
          type = "internal/date";
          interval = 1;

          date = "%H:%M";
          date-alt = "%Y-%m-%d %H:%M:%S";

          label = "%date%";
          label-foreground = "\${colors.primary}";
        };
      };
    };
  };
}
