# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, host, user, ... }:
{

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # systemd
  systemd = {
    # user.services.polybar = {
    #   Unit.After = [ "graphical-session-i3.target" ];
    #  "Install.WantedBy" = lib.mkForce [ "graphical-session-i3.target" ];
    #};


    #user.services.polkit-gnome-authentication-agent-1 = {
    # description = "polkit-gnome-authentication-agent-1";
    # wantedBy = [ "graphical-session.target" ];
    # wants = [ "graphical-session.target" ];
    # after = [ "graphical-session.target" ];
    # serviceConfig = {
    #     Type = "simple";
    #    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #    Restart = "on-failure";
    #    RestartSec = 1;
    #    TimeoutStopSec = 10;
    #  };
    # };
  };

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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

  # zfs examines all data in the specified pools to verify that it checksums correctly.
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # Sanoid is a snapshotting tool for ZFS
  # How to format drives to ZFS:
  # 1. Wipe drive using GParted
  # 2. ls -al /dev/disk/by-id
  # 3. sudo zpool create -f -o -ashift=12 -O compression=on -O acltype=posixacl -O atime=off -O xattr=sa -O normalization=formD -O mountpoint=none POOL_NAME /dev/disk/by-id/ata... 
  ## add "-o autotrim=on" if using a SSD
  # 4. sudo zfs create -o mountpoint=legacy DATASET 
  ## When creating a dataset you must make a dataset for each level for example doing /media/2TB_SSHD you need to make a dataset for media and media/2TB_SSHD
  services.sanoid = {
    enable = true;
    datasets."zfs-pool-2TB_SSHD/media" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zfs-pool-2TB_SSHD/media/2TB_SSHD" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zroot/safe" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
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

  programs.light = {
    enable = true;
  };

  programs.steam.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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

  # enable flakes
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
