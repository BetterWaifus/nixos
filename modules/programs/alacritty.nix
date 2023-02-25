{ pkgs, host, config, user, ... }: {
home-manager.users.${user} = {
  programs.alacritty = {
    enable = true;
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