{
  pkgs,
  user,
  config,
  ...
}: {
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      (
        if config.styley.hyprland.enable
        then rofi-wayland
        else rofi
      )
    ];
    home.file = {
      ".config/rofi/config.rasi".text = ''
        /* Rounded Dark theme. */
        @import "~/.cache/wal/colors-rofi-rounded.rasi"
      '';
    };
    home.file.".config/wal/templates/colors-rofi-rounded.rasi" = {
      source = ./colors-rofi.rasi;
      recursive = true;
    };
  };
}
