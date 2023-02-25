{ pkgs, user, config, ... }: {
  services.gvfs.enable = true;

  home-manager.users.${user} = {
    home = { packages = with pkgs; [ dconf ]; };

    gtk = {
      enable = true;
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };
  };
}
