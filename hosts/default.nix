{ config, pkgs, user, lib, host, ... }:
{
  options.styley.font = lib.mkOption {
    default = "Inter";
  };
  options.styley.monospacefont = lib.mkOption {
    default = "JetBrainsMono Nerd Font";
  };
  options.styley.hyprland.displays = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
  options.styley.hyprland.monitors = {
    monitor1 = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The name of the primary display, e.g. eDP-1";
    };
    monitor2 = lib.mkOption {
      type = lib.types.str;
      default = config.styley.hyprland.monitors.monitor1;
      description = "The name of the secondary display, e.g. eDP-1";
    };
    monitor3 = lib.mkOption {
      type = lib.types.str;
      default = config.styley.hyprland.monitors.monitor1;
      description = "The name of the tertiary display, e.g. eDP-1";
    };
  };

  options.styley.media.enable = lib.mkEnableOption "media";
  options.styley.picom.enable = lib.mkEnableOption "picom";
  options.styley.i3.enable = lib.mkEnableOption "i3";
  options.styley.hyprland.enable = lib.mkEnableOption "hyprland";
  imports = [
    ./configuration.nix
    ./home.nix
  ];
}
