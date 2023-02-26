{ pkgs, user, ... }: {
  home-manager.users.${user} = {
    home = { packages = with pkgs; [ cinnamon.nemo rar ]; };

    gtk.gtk3.bookmarks = [
      "file:///home/${user}/Downloads"
      "file:///home/${user}/Documents"
      "file:///home/${user}/Pictures"
      "file:///persist"
    ];

    dconf.settings = {
      "org/gnome/desktop/applications/terminal" = {
        exec = "alacritty";
      };
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "alacritty";
      };
      "org/nemo/preferences" = {
        default-folder-viewer = "list-view";
        show-hidden-files = true;
        start-with-dual-pane = true;
      };
      "org/nemo/preferences/menu-config" = {
        selection-menu-make-link = true;
        selection-menu-copy-to = true;
        selection-menu-move-to = true;
      };
    };
  };

  styley.persist.home.directories = [
  ];
}
