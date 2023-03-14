{ config, pkgs, user, lib, host, ... }:
{
  options = lib.mkIf config.styley.tlp.enable {
    services.tlp = {
      enable = true;
    };
  };
}
