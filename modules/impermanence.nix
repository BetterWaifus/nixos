{
  config,
  user,
  lib,
  ...
}: let
  cfg = config.styley.persist;
in {
  options.styley.persist = {
    root = {
      directories = lib.mkOption {
        default = [];
        description = "Directories to persist in root filesystem";
      };
      files = lib.mkOption {
        default = [];
        description = "Files to persist in root filesystem";
      };
    };
    home = {
      directories = lib.mkOption {
        default = [];
        description = "Directories to persist in home directory";
      };
      files = lib.mkOption {
        default = [];
        description = "Files to persist in home directory";
      };
    };
  };

  config = {
    boot.initrd.postDeviceCommands = lib.mkAfter "zfs rollback -r zroot/local/root@blank";

    fileSystems."/persist".neededForBoot = true;

    users.mutableUsers = false;
    # mkpasswd -m sha-512 'MY_ROOT_PASSWORD' | sudo tee -a /persist/etc/shadow/root
    users.users.root.passwordFile = "/persist/etc/shadow/root";
    users.users.${user}.passwordFile = "/persist/etc/shadow/${user}";

    # persist files on root filesystem
    environment.persistence."/persist" = {
      hideMounts = true;
      files = ["/etc/machine-id"] ++ cfg.root.files;
      directories = cfg.root.directories;

      # persist for home directory
      users.${user} = {
        files = cfg.home.files;
        directories =
          [
            # TODO: reference projects on another dataset?
          ]
          ++ cfg.home.directories;
      };
    };
  };
}
