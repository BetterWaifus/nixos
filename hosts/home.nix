{ config, pkgs, user, host, ... }:
{
  imports = [
    ../modules
  ];

  home-manager.users.${user} = {
    home.stateVersion = "23.05";

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      vscode
      firefox
      nix
      nil
      nixpkgs-fmt
      xorg.xrandr
      arandr
      pulseaudio
      maim
      light
      xclip
      neofetch
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
      mate.engrampa
      vlc
      i3lock-color
      xfce.xfce4-taskmanager
      xfce.xfce4-power-manager
      gimp-with-plugins
      pywal
      rofi
      pavucontrol
      armcord
      looking-glass-client
      bottles
    ];

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
