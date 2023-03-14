{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      "Downloads"
      "Documents"
      "Pictures"
      "Documents/Apps"
    ];
    styley.persist.root.directories = [
      "root/.parsec"
    ];
  };
}
