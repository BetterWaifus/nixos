{ pkgs, user, lib, config, ... }: {
  config = {
    services.sonarr = {
      enable = true;
      user = user;
    };

    styley.persist.root.directories = [
      "/var/lib/sonarr/.config/NzbDrone"
    ];
  };
}
