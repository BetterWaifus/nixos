{ pkgs, user, ... }: {
  services.gvfs.enable = true;

  home-manager.users.${user} = {
    home = { packages = with pkgs; [ dconf ]; };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Sky-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "sky" ];
          variant = "mocha";
          size = "compact";
        };
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
