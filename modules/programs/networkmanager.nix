{ pkgs, user, config, ... }:
{
  config = {
    styley.persist.root.directories = [
      "etc/NetworkManager"
    ];
  };
}
