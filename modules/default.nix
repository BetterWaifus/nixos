{ pkgs, host, user, ... }: {
  imports = [
    ./desktop/polybar.nix
    ./desktop/gtk.nix
    ./desktop/rofi.nix
    ./desktop/i3.nix
    ./desktop/feh.nix
    ./desktop/pywal.nix
    ./impermanence.nix
    ./home_folders.nix
    ./programs/alacritty.nix
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
    ./programs/transmission.nix
    ./programs/transmission-remote-gtk.nix
    ./programs/sanoid.nix
  ];
}
