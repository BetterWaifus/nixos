{ pkgs, host, config, user, ... }: {
home-manager.users.${user} = {
  programs.alacritty = {
    settings = {
      font = {
      normal = {
      family = config.styley.font;
      style = "Regular";

        };
      };
     };
    };
  };
}