{ pkgs, user, lib, config, ... }:
{
  config = lib.mkIf config.styley.hyprland.enable {
    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        settings = [ ];
      };
    };
  };
}
