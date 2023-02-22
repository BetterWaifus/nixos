{ config, pkgs, user, host, ... }:
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
      xclip
      neofetch
    ];

    home.file = {
      ".config/rofi/config.rasi".text = ''
       /* Dark theme. */
       @import "~/.cache/wal/colors-rofi-dark"
      '';

    };

    home.file."./.bashrc" = {
      source=../modules/bashrc/bashrc.conf;
      recursive = true;
    };
  };
}
