{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".cache/appimage-run"
    ];
  };
}
