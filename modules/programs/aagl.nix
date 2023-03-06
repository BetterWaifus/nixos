{ pkgs, config, ... }:
{
  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  styley.persist.home.directories = [
    ".local/share/anime-game-launcher"
  ];

  programs.an-anime-game-launcher.enable = true;
}
