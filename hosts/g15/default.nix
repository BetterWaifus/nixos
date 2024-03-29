{
  config,
  pkgs,
  user,
  lib,
  ...
}: {
  imports = [./hardware.nix];

  config = {
    styley = {
      media.enable = false;
      picom.enable = false;
      i3.enable = false;
      hyprland.enable = true;
      hyprland.monitors = {
        monitor1 = "eDP-1";
      };
      hyprland.displays = " 
        monitor=${config.styley.hyprland.monitors.monitor1},2560x1440@60,0x0,1.5
        workspace=${config.styley.hyprland.monitors.monitor1},1
        ";
    };

    boot.loader = {
      # systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        extraEntries = lib.concatStringsSep "\n" [
          ''
            menuentry "Windows 11" {
              insmod part_gpt
              insmod fat
              insmod search_fs_uuid
              insmod chain
              search --fs-uuid --set=root A89B-B87E
              chainloader /EFI/Microsoft/Boot/bootmgfw.efi
            }
          ''
        ];
      };
    };

    services.tlp.enable = false;
    services.thermald.enable = true;
    # enables ASUS services
    programs.rog-control-center = {
      enable = true;
      autoStart = true;
    };
    services.asusd.enable = true;
    services.asusd.enableUserService = true;
    services.power-profiles-daemon.enable = false;
    services.tlp = {
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    home-manager.users.${user} = {
      home.packages = with pkgs; [
        #A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
        asusctl
      ];

      xsession.windowManager.i3 = lib.mkIf config.styley.i3.enable {
        config = {
          assigns = {
            "1" = [{class = "^firefox$";} {class = "^discord$";}];
          };
          startup = [
            {
              command = "xrandr --output eDP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --rate 165 --output HDMI-1 --off";
              always = true;
              notification = false;
            }
            {
              command = "${pkgs.feh}/bin/feh --bg-fill ${../../modules/desktop/wallpaper/desktop}";
              always = true;
              notification = false;
            }
            {
              command = "wal -c && wal -i ${../../modules/desktop/wallpaper/desktop}";
              always = true;
              notification = false;
            }
            {
              command = lib.mkAfter "exec firefox";
              always = true;
              notification = false;
            }
            {
              command = lib.mkAfter "exec discord";
              always = true;
              notification = false;
            }
          ];
        };
      };
    };

    # Enables AMD GPU drivers
    services.xserver.videoDrivers = ["amdgpu"];
    hardware.opengl.enable = true;
  };
}
