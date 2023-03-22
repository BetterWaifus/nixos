{
  pkgs,
  user,
  theme,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.styley.i3.enable {
    home-manager.users.${user} = {
      home.file = {
        "lock.sh".text = ''
          #!/bin/sh

          BLANK='#00000000'
          CLEAR='#00000000'
          DEFAULT='#00000000'
          TEXT='#ffffffff'
          WRONG='#00000000'
          VERIFYING='#00000000'

          i3lock \
          --insidever-color=$CLEAR           \
          --ringver-color=$VERIFYING         \
          \
          --insidewrong-color=$CLEAR         \
          --ringwrong-color=$WRONG           \
          \
          --inside-color=$BLANK              \
          --ring-color=$DEFAULT              \
          --line-color=$BLANK                \
          --separator-color=$DEFAULT         \
          \
          --verif-color=$BLANK                \
          --wrong-color=$BLANK               \
          --time-color=$TEXT                 \
          --date-color=$TEXT                 \
          --layout-color=$TEXT               \
          --keyhl-color=$WRONG               \
          --bshl-color=$WRONG                \
          \
          --screen 1                         \
          --blur 5                           \
          --clock                            \
          --indicator                        \
          --time-font=${config.styley.font}  \
          --date-font=${config.styley.font}  \
          --time-str="%H:%M"                 \
          --date-str="%m-%d-%Y"              \
        '';
      };
    };
  };
}
