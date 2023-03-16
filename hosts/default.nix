{ config, pkgs, user, lib, host, ... }:
{
  options.styley.font = lib.mkOption {
    default = "Inter";
  };
  options.styley.monospacefont = lib.mkOption {
    default = "JetBrainsMono Nerd Font";
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
