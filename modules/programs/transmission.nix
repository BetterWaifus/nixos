{ pkgs, user, lib, config, ... }:
{
  config = {
    services.transmission =
      {
        enable = true;
        user = user;
        home = "/home/${user}";
      };

  };
}
