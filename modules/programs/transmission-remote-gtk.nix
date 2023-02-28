{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".config/transmission-remote-gtk"
    ];
  };
}
