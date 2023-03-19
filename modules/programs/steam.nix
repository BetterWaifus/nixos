{ pkgs, user, config, ... }:
{
  config = {
    # Enables Steam controller support and other steam related services
    programs.steam.enable = true;

    styley.persist.home.directories = [
      ".steam"
    ];
  };
}
