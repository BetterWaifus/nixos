{ config, pkgs, lib, host, user, ... }:
{

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Sets i3 as default display manager
  environment.pathsToLink = [ "/libexec" ];
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enables automatic gnome-keyring unlock
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpenGL 32bit support
  hardware.opengl.driSupport32Bit = true;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # shut sudo up
  security.sudo.extraConfig = "Defaults lecture=never";

  # Enable ALSA sound
  security.rtkit.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.extraUsers.${user}.extraGroups = [ "audio" "video" ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "${user}";
    };
  };

  # zfs examines all data in the specified pools to verify that it checksums correctly.
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    variables = {
      TERMINAL = "alacritty";
    };
    systemPackages = with pkgs; [
      curl
      git
      exa
      killall
      neovim
      ntfs3g
      ripgrep
      tree
      wget
      gparted
      alacritty
      vscode
      sanoid
      appimage-run

      # support both 32- and 64-bit applications
      wineWowPackages.stable

      # support 32-bit only
      wine

      # support 64-bit only
      (wine.override { wineBuild = "wine64"; })

      # wine-staging (version with experimental features)
      wineWowPackages.staging

      # winetricks (all versions)
      winetricks
    ];
  };

  # setup fonts
  fonts = {
    fonts = with pkgs; [
      font-awesome
      roboto-mono
      rounded-mgenplus
      inter
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Ubuntu" ]; })
    ];
  };

  # Adjusting brightness
  programs.light = {
    enable = true;
  };

  # Enables Steam controller support and other steam related services
  #programs.steam.enable = true;

  # Set Default Applications
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "nemo.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
    };
  };

  # Uses hardware clock to determine time within Nix
  time.hardwareClockInLocalTime = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # Enable Flakes
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    # use flakes
    extraOptions = "experimental-features = nix-command flakes";
  };
}
