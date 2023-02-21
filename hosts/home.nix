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
      polybar
      rofi
      picom
      feh
      pywal
      arandr
      jetbrains-mono
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
            family: JetBrains Mono
            style: Regular
      '';

    };
  };
}
