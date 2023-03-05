{ pkgs, user, lib, config, ... }: {

  home-manager.users.${user} = {
    options = {
      programs = {
        kodi = {
          enable = true;
          datadir = "~/.kodi";
        };
      };
    };
  };

  config = {
    styley.persist.home.directories = [
      ".kodi"
    ];
  };
}
