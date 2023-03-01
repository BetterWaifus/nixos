{ config, pkgs, user, host, ... }:
{
  imports = [
    ../modules
  ];

  home-manager.users.${user} = {
    home.stateVersion = "22.11";

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      vscode
      firefox
      nix
      nil
      nixpkgs-fmt
      xorg.xrandr
      rofi
      picom
      feh
      pywal
      arandr
      pulseaudio
      maim
      light
      xclip
      neofetch
      virt-manager
      steam
      parsec-bin
      dolphin-emu
      yuzu-early-access
      ryujinx
      protonup-qt
      protontricks
      cinnamon.nemo
      keepass
      obs-studio
      gnome.gnome-clocks
      gnome.seahorse
      gnome.eog
      winetricks
      wine-staging
      heroic
      nixpkgs-fmt
      nil
      zip
      vlc
      i3lock-color
    ];

    home.file = {
      ".config/rofi/config.rasi".text = ''
        /* Dark theme. */
        @import "~/.cache/wal/colors-rofi-dark"
      '';
    };

    home.file."./.bashrc" = {
      source = ../modules/programs/bashrc/bashrc.conf;
      recursive = true;
    };
  };
}
