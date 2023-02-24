{ pkgs, host, user, ... }: {
  imports = [
    ./desktop/polybar.nix
  ];
}
