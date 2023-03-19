{ pkgs, inputs, user, host, ... }:
let
  hypr-wallpaper = pkgs.writeShellScriptBin "hypr-wallpaper" ''
    wal -n -i "${../wallpaper/${host}}"
    swww img "$(< "$HOME/.cache/wal/wal")"
  '';
  hypr-colors = pkgs.writeShellScriptBin "hypr-colors" ''
    source ~/.cache/wal/colors.sh

    hyprctl keyword general:col.active_border "rgba(''${color4:1:10}ee) rgba(''${color5:1:10}ee) 45deg"
    hyprctl keyword general:col.inactive_border "rgba(''${color0:1:10}ee)"
    hyprctl keyword windowrulev2 bordercolor "rgba(''${color6:1:10}ff),fullscreen:1" 
    hyprctl keyword windowrulev2 bordercolor "rgba(''${color9:1:10}ff),floating:1" 
  '';
in
{
  config = {
    home-manager.users.${user} = {
      home = {
        packages = [
          hypr-wallpaper
          hypr-colors
          inputs.nixpkgs-wayland.packages.x86_64-linux.swww
        ];
      };
    };
  };
}
