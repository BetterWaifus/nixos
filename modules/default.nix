{...}: {
  imports = [
    # Desktop
    ./desktop/dunst.nix
    ./desktop/gtk.nix
    ./desktop/rofi/rofi.nix
    ./desktop/pywal.nix
    #i3
    ./desktop/i3/default.nix
    ./desktop/i3/i3lock.nix
    ./desktop/i3/feh.nix
    ./desktop/i3/picom.nix
    ./desktop/i3/polybar.nix
    #hyprland
    ./desktop/hyprland/default.nix
    ./desktop/hyprland/nvidia.nix
    ./desktop/hyprland/waybar.nix
    ./desktop/hyprland/wallpaper.nix

    # Misc
    ./impermanence.nix
    ./persist.nix
    ./zfs.nix

    # Programs
    ./programs/kitty.nix
    ./programs/nemo.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/nixos.nix
    ./programs/share.nix
    ./programs/steam.nix
    ./programs/git.nix
    ./programs/heroic.nix
    ./programs/keyring.nix
    ./programs/appimage-run.nix
    ./programs/networkmanager.nix
    ./programs/sanoid.nix
    # An Anime Game Launcher is for Genshin Impact
    ./programs/aagl.nix

    # Media
    ./media/transmission.nix
    ./media/sonarr.nix
  ];
}
