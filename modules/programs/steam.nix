{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".steam"
    ];
    styley.persist.home.files = [
      ".steampath"
      ".steampid"
    ]
  };
}