{ config, pkgs, user, lib, host, inputs, ... }:
{
  config = lib.mkIf config.styley.hyprland.enable {
    home-manager.users.${user} = {
      imports = [ inputs.hyprland.homeManagerModules.default ];

      home = {
        sessionVariables = {
          "XCURSOR_SIZE" = "24";
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        xwayland.hidpi = false;
        extraConfig = "source=~/.config/hypr/hyprland1.conf";
      };
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";

        initial_session = {
          command = "Hyprland";
          inherit user;
        };
      };
    };
  };
}
