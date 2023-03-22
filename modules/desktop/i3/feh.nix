{
  pkgs,
  user,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.styley.i3.enable {
    styley.persist.home.files = [
      ".fehbg"
    ];
  };
}
