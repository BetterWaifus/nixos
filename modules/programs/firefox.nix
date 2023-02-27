{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".cache/mozilla"
      ".mozilla"
    ];
  };
}
