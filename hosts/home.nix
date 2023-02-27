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
      i3lock
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
      discord-canary
      betterdiscordctl
      keepass
      obs-studio
      gnome.gnome-clocks
      gnome.seahorse
      winetricks
      wine-staging
      heroic
      ranger
      nixpkgs-fmt
      nil
      zip
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

    home.file.".config/BetterDiscord/themes/pywal-discord-abou.css" = {
      source = ../modules/programs/pywal-discord/pywal-discord-abou.css;
      recursive = true;
    };

    home.file.".config/BetterDiscord/themes/pywal-discord-default.css" = {
      source = ../modules/programs/pywal-discord/pywal-discord-default.css;
      recursive = true;
    };

    home.file.".config/ranger" = {
      source = ../modules/programs/ranger;
      recursive = true;
    };
  };
}
