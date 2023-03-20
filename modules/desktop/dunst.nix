{ user, config, ... }: {
  config = {
    home-manager.users.${user} = {
      home.file = {
        ".config/wal/templates/dunstrc.conf".text = ''
          [brightness-change]
          appname="brightness-change"
          history_ignore="yes"

          [global]
          corner_radius=10
          dmenu="rofi -p dunst:"
          ellipsize="end"
          font="${config.styley.font} Regular 12"
          frame_color="{color4}"
          frame_width=2
          horizontal_padding=10
          max_icon_size=72
          separator_color="{color4}"
          separator_height=1
          show_indicators="no"
          transparency=15

          [urgency_critical]
          background="{color0}"
          foreground="{color7}"
          timeout=0

          [urgency_low]
          background="{color0}"
          foreground="{color7}"
          timeout=10

          [urgency_normal]
          background="{color0}"
          foreground="{color7}"
          timeout=10

          [volume-change]
          appname="volume-change"
          history_ignore="yes"

        '';
      };
      services = {
        dunst = {
          enable = true;
          configFile = "~/.cache/wal/dunstrc.conf";
        };
      };
    };
  };
}
