{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.home.directories = [
      ".config/Code"
      ".vscode"
    ];
  };
}
