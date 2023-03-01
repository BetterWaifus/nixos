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

    home.file = {
      "lock.sh".text = ''
        #!/bin/sh

        BLANK='#00000000'
        CLEAR='#00000000'
        DEFAULT='#00000000'
        TEXT='#ffffffff'
        WRONG='#00000000'
        VERIFYING='#00000000'

        i3lock \
        --insidever-color=$CLEAR           \
        --ringver-color=$VERIFYING         \
        \
        --insidewrong-color=$CLEAR         \
        --ringwrong-color=$WRONG           \
        \
        --inside-color=$BLANK              \
        --ring-color=$DEFAULT              \
        --line-color=$BLANK                \
        --separator-color=$DEFAULT         \
        \
        --verif-color=$BLANK                \
        --wrong-color=$BLANK               \
        --time-color=$TEXT                 \
        --date-color=$TEXT                 \
        --layout-color=$TEXT               \
        --keyhl-color=$WRONG               \
        --bshl-color=$WRONG                \
        \
        --screen 1                         \
        --blur 5                           \
        --clock                            \
        --indicator                        \
        --time-font=${config.styley.font}  \
        --date-font=${config.styley.font}  \
        --time-str="%H:%M"                 \
        --date-str="%m-%d-%Y"              \ 
      '';
    };
  };
}
