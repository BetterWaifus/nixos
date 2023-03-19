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
          icon_path="/run/current-system/sw/share/icons/hicolor/32x32/actions:/run/current-system/sw/share/icons/hicolor/32x32/animations:/run/current-system/sw/share/icons/hicolor/32x32/apps:/run/current-system/sw/share/icons/hicolor/32x32/categories:/run/current-system/sw/share/icons/hicolor/32x32/devices:/run/current-system/sw/share/icons/hicolor/32x32/emblems:/run/current-system/sw/share/icons/hicolor/32x32/emotes:/run/current-system/sw/share/icons/hicolor/32x32/filesystem:/run/current-system/sw/share/icons/hicolor/32x32/intl:/run/current-system/sw/share/icons/hicolor/32x32/legacy:/run/current-system/sw/share/icons/hicolor/32x32/mimetypes:/run/current-system/sw/share/icons/hicolor/32x32/places:/run/current-system/sw/share/icons/hicolor/32x32/status:/run/current-system/sw/share/icons/hicolor/32x32/stock:/home/styley/.nix-profile/share/icons/hicolor/32x32/actions:/home/styley/.nix-profile/share/icons/hicolor/32x32/animations:/home/styley/.nix-profile/share/icons/hicolor/32x32/apps:/home/styley/.nix-profile/share/icons/hicolor/32x32/categories:/home/styley/.nix-profile/share/icons/hicolor/32x32/devices:/home/styley/.nix-profile/share/icons/hicolor/32x32/emblems:/home/styley/.nix-profile/share/icons/hicolor/32x32/emotes:/home/styley/.nix-profile/share/icons/hicolor/32x32/filesystem:/home/styley/.nix-profile/share/icons/hicolor/32x32/intl:/home/styley/.nix-profile/share/icons/hicolor/32x32/legacy:/home/styley/.nix-profile/share/icons/hicolor/32x32/mimetypes:/home/styley/.nix-profile/share/icons/hicolor/32x32/places:/home/styley/.nix-profile/share/icons/hicolor/32x32/status:/home/styley/.nix-profile/share/icons/hicolor/32x32/stock:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/actions:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/animations:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/apps:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/categories:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/devices:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/emblems:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/emotes:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/filesystem:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/intl:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/legacy:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/mimetypes:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/places:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/status:/nix/store/pddvsy65nq6nqhyx48payk9cfkw8kx7m-hicolor-icon-theme-0.17/share/icons/hicolor/32x32/stock"
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
