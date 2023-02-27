{ pkgs, user, config, ... }:
{
  environment = {
    systemPackages = with pkgs; [ git ];
  };

  home-manager.users.${user} = {
    programs = {
      git = {
        enable = true;
        userName = "STYLEY";
        userEmail = "ssstyley@gmail.com";
      };
    };
  };
}
