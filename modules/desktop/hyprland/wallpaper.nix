{ pkgs, inputs, system, user, lib, config, ... }:
let
  cfg = config.styley.hyprland;
  hypr-wallpaper = pkgs.writeShellScriptBin "hypr-wallpaper" (lib.concatStringsSep "\n" (
    (lib.mapAttrsToList
      (monitor: wallpaper: "swww img -o ${monitor} --transition-type grow ${wallpaper}")
      cfg.wallpapers)
  ));
in
{
  options.styley.hyprland = {
    wallpapers = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = { };
      description = "Attrset of wallpapers to use for swww";
      example = ''{
        DP-2 = "/path/to/wallpaper.png";
      }'';
    };
  };

  config = {
    home-manager.users.${user} = {
      home = {
        packages = [
          hypr-wallpaper
          inputs.nixpkgs-wayland.packages.x86_64-linux.swww
        ];
      };
    };
  };
}
