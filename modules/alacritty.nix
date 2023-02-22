{ pkgs, host, user, ... }: {
home-manager.users.${user} = {
  programs.alacritty = {
    settings = {
      font = {
      normal = {
      family = styley.fonts;
      style = "Regular";

        };
      };
     };
    };
  };
}