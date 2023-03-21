{ pkgs, user, ... }:
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
      jq
      nixpkgs-fmt
      xorg.xrandr
      xorg.xev
      xorg.xhost
      arandr
      pulseaudio
      maim
      light
      xclip
      neofetch
      protonup-qt
      protontricks
      cinnamon.nemo
      keepass
      obs-studio
      gnome.gnome-clocks
      gnome.seahorse
      gnome.eog
      gnome.file-roller
      heroic
      nixpkgs-fmt
      nil
      vlc
      i3lock-color
      gimp-with-plugins
      pavucontrol
      webcord
      lutris
      libnotify
      autotiling
      gamescope
      playerctl
      openrgb
      nvtop-amd
      powertop
      (pkgs.callPackage ../modules/programs/parsec.nix { })
    ];

    home.file."./.bashrc" = {
      source = ../modules/programs/bashrc/bashrc.conf;
      recursive = true;
    };
  };
}
