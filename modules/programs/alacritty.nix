{ pkgs, host, config, user, ... }: 
let
  # create a fake gnome-terminal shell script so xdg terminal applications
  # will open in alacritty
  # https://unix.stackexchange.com/a/642886
  fakeGnomeTerminal = pkgs.writeShellScriptBin "gnome-terminal" ''
    shift
    TITLE="$(basename "$1")"
    if [ -n "$TITLE" ]; then
      ${pkgs.alacritty}/bin/alacritty -t "$TITLE" -e "$@"
    else
      ${pkgs.alacritty}/bin/alacritty -e "$@"
    fi
  '';
in
{
  environment.systemPackages = [ fakeGnomeTerminal ];
  
  home-manager.users.${user} = {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
        normal = {
          family = 
          "${config.styley.monospacefont}";
          style = "Regular";
          };
          bold = {style = "Bold"; };
          italic = { style = "Italic"; };
          size = 11;
        };
      };
      };
    };
}
