{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".steam"
    ];
  };
}
