{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      "Downloads"
      "Documents"
      "Pictures"
    ];
  };
}