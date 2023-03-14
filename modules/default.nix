{ pkgs, host, user, ... }: {
  imports = [
    # Desktop
    ./desktop/polybar.nix
    ./desktop/gtk.nix
    ./desktop/rofi.nix
    ./desktop/i3.nix
    ./desktop/feh.nix
    ./desktop/pywal.nix
    ./desktop/picom.nix
    ./desktop/dunst.nix

    # Misc
    ./impermanence.nix
    ./home_folders.nix
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
