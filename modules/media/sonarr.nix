{ pkgs, user, lib, config, ... }: {
  config = lib.mkIf config.styley.media.enable {
    services.sonarr = {
      enable = true;
      user = user;
    };

    styley.persist.root.directories = [
      "/var/lib/sonarr/.config/NzbDrone"
    ];
  };
}
