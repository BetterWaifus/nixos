{ pkgs, user, theme, config, lib, ... }:
{
  home-manager.users.${user} = {
    home.file = {
      ".config/rofi/config.rasi".text = ''
        /* Dark theme. */
        @import "~/.cache/wal/colors-rofi-dark"
      '';
    };
  };
}
