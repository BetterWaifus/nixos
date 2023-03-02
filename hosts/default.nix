{ config, pkgs, user, lib, host, ... }:
{
  options.styley.font = lib.mkOption {
    default = "Inter";
  };
  options.styley.monospacefont = lib.mkOption {
    default = "JetBrainsMono Nerd Font";
  };
  imports = [
    ./configuration.nix
    ./home.nix
  ];
}
