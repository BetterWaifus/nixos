{
  pkgs,
  user,
  host,
  ...
}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    cd /home/styley/nixos
    sudo nixos-rebuild switch --flake ".#${host}"
  '';
in {
  imports = [
    ../modules
  ];

  home-manager.users.${user} = {
    home.stateVersion = "23.05";

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      #scripts
      rebuild

      #packages
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
      discord
      lutris
      bottles
      libnotify
      autotiling
      gamescope
      playerctl
      openrgb
      nvtop
      powertop
      slurp
      alejandra
      fd
      lm_sensors
      (pkgs.callPackage ../modules/programs/parsec.nix {})
    ];

    home.file."./.bashrc" = {
      source = ../modules/programs/bashrc/bashrc.conf;
      recursive = true;
    };
  };
}
