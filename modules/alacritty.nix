{ pkgs, host, config, user, ... }: {
home-manager.users.${user} = {
  programs.alacritty = {
    settings = {
      font = {
      normal = {
        family = 
        "JetBrains Mono";
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