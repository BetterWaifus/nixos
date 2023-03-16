{ pkgs, user, config, lib, ... }:
{
  config = {
    home-manager.users.${user} = {
      programs.pywal = {
        enable = true;
      };
    };
  };
}
