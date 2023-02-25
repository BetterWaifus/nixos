{ config, pkgs, user, host, ... }:
{
  imports = [
    ../modules
    ../modules/programs/alacritty.nix
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
      spotifyd
      spotify-tui
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

    home.file."./.config/spotifyd/spotifyd.conf" = {
      source=../modules/programs/spotifyd/spotifyd.conf;
      recursive = true;
    };

    home.file."./.config/spotify-tui/.spotify_token_cache.json" = {
      source=../modules/programs/spotify-tui/.spotify_token_cache.json;
      recursive = true;
    };

    home.file."./.config/spotify-tui/client.yml" = {
      source=../modules/programs/spotify-tui/client.yml;
      recursive = true;
    };
  };
}
