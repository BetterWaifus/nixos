{ pkgs, user, theme, config, lib, ... }:
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [ (if config.styley.hyprland.enable then rofi-wayland else rofi) ];
    home.file = {
      ".config/rofi/config.rasi".text = ''
        /* Dark theme. */
        @import "~/.cache/wal/colors-rofi-dark"
      '';
    };
  };
}
