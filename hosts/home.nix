{ config, pkgs, user, host, ... }:
{
  imports = [
    ../modules
    ../modules/programs/alacritty.nix
    ../modules/programs/firefox.nix
    ../modules/programs/nemo.nix
    ../modules/desktop/gtk.nix
  ];

  home-manager.users.${user} = {
    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      vscode
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
      looking-glass-client
      obs-studio
      gnome.gnome-clocks
      wineWowPackages.unstableFull
    ];

    home.file = {
      ".config/rofi/config.rasi".text = ''
       /* Dark theme. */
       @import "~/.cache/wal/colors-rofi-dark"
      '';
    };

    home.file."./.bashrc" = {
      source=../modules/programs/bashrc/bashrc.conf;
      recursive = true;
    };

    home.file.".config/BetterDiscord/themes/pywal-discord-abou.css" = {
      source=../modules/programs/pywal-discord/pywal-discord-abou.css;
      recursive = true;
    };

    home.file.".config/BetterDiscord/themes/pywal-discord-default.css" = {
      source=../modules/programs/pywal-discord/pywal-discord-default.css;
      recursive = true;
    };
  };
}
