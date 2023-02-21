{ config, pkgs, user, host, font, ... }:
{
  imports = [
    ../modules
  ];

  home-manager.users.${user} = {
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      alacritty
      vscode
      firefox
      nix
      nil
      nixpkgs-fmt
      xfce.thunar
      xorg.xrandr
      polybar
      rofi
      picom
      feh
      pywal
      arandr
      jetbrains-mono
      roboto
      i3lock
      pulseaudio
      maim
      light
    ];

    home.file = {
      ".config/alacritty/alacritty.yml".text = ''
        # Font configuration
        font:
          normal:
            family: ${font}
            style: Regular
      '';

    };

    home.file = {
      ".config/rofi/config.rasi".text = ''
       /* Dark theme. */
       @import "~/.cache/wal/colors-rofi-dark"
      '';

    };

    home.file.".config/bashrc/.bashrc" = {
      source=../modules/bashrc/bashrc.conf;
      recursive = true;
    };
  };
}
