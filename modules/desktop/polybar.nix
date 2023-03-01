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

          separator = " ";
          separator-foreground = "\${colors.disabled}";

          font-0 = "${config.styley.font}:size=12;3";
          font-1 = "${config.styley.monospacefont}:pixelsize=12;3";

          modules-left = "xworkspaces xwindow";
          modules-right = "wlan lan backlight volume battery date";

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

        "module/volume" = {
          type = "internal/alsa";

          format-volume = "<ramp-volume>  <label-volume>";
          format-muted = "<label-muted>  MUTE";
          label-volume = "%percentage%%";
          label-muted = "";
          label-muted-foreground = "\${colors.disabled}";
          format-volume-padding = 0;
          format-muted-padding = 0;

          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
          ramp-headphones-0 = "";
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

        "module/backlight" = {
          type = "internal/backlight";
          card = "intel_backlight";
          enable-scroll = true;
          format-prefix = "☀ ";
          format = "<label>";
          label = "%percentage%%";
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

        "module/lan" = {
          type = "internal/network";

          interface = "enp0s31f6";

          interval = 1;

          label-connected = "";
          label-disconnected = "";
          label-disconnected-foreground = "%{F#F0C674}%ifname%%{F#707880} disconnected";
        };

        "module/wlan" = {
          type = "internal/network";

          interface = "wlp2s0";

          interval = 1;

          label-connected = "%{A:xst -e nmtui&:}直  %essid%%{A}";
          label-disconnected = "%{A:xst -e nmtui&:}睊%{A}";
          label-disconnected-foreground = "%{F#F0C674}%ifname%%{F#707880} disconnected";
        };

        "module/battery" = {
          type = "internal/battery";

          full-at = 99;

          battery = "BAT1";
          adapter = "AC0";

          poll-interval = 5;

          format-charging = "<animation-charging>  <label-charging>";
          format-discharging = "<ramp-capacity>  <label-discharging>";
          format-full = "<ramp-capacity>  <label-full>";
          label-charging = "%percentage%%";
          label-discharging = "%percentage%%";
          label-full = "%percentage%%";
          format-charging-padding = 0;
          format-discharging-padding = 0;
          format-full-padding = 0;

          ramp-capacity-0 = " ";
          ramp-capacity-1 = " ";
          ramp-capacity-2 = " ";
          ramp-capacity-3 = " ";
          ramp-capacity-4 = " ";

          animation-charging-0 = " ";
          animation-charging-1 = " ";
          animation-charging-2 = " ";
          animation-charging-3 = " ";
          animation-charging-4 = " ";
          animation-charging-framerate = 750;
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
