{ pkgs, host, user, ... }: {
  imports = [
    ./desktop/polybar.nix
    ./desktop/gtk.nix
    ./impermanence.nix
    ./home_folders.nix
    ./programs/alacritty.nix
    ./programs/nemo.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/nixos.nix
    ./programs/betterdiscord.nix
    ./programs/discordcanary.nix
    ./programs/share.nix
    ./programs/steam.nix
    ./programs/git.nix
    ./programs/heroic.nix
    ./programs/keyring.nix
  ];
}
