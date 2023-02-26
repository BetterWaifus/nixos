{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".local/share"
    ];
  };
}