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
  options.styley.tlp.enable = lib.mkEnableOption "tlp";
  imports = [
    ./configuration.nix
    ./home.nix
  ];
}
