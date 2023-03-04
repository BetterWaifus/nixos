{ pkgs, user, lib, config, ... }:
{
  config = {
    # transmission dark mode, the default theme is hideous
    nixpkgs.overlays = [
      (self: super: {
        transmission = super.transmission.overrideAttrs
          (old: rec {
            themeSrc = super.fetchzip
              {
                url = "https://git.eigenlab.org/sbiego/transmission-web-soft-theme/-/archive/master/transmission-web-soft-theme-master.tar.gz";
                sha256 = "sha256-TAelzMJ8iFUhql2CX8lhysXKvYtH+cL6BCyMcpMaS9Q=";
              };
            # sed command taken from original install.sh script
            postInstall = ''
              ${old.postInstall}
              cp -RT ${themeSrc}/web/ $out/share/transmission/web/
              sed -i '21i\\t\t<link href="./style/transmission/soft-theme.min.css" type="text/css" rel="stylesheet" />\n\t\t<link href="style/transmission/soft-dark-theme.min.css" type="text/css" rel="stylesheet" />\n' $out/share/transmission/web/index.html;
            '';
          });
      })
    ];

    services = {
      transmission = {
        enable = true;
        settings = {
          alt-speed-down = 50;
          alt-speed-enabled = false;
          alt-speed-time-begin = 540;
          alt-speed-time-day = 127;
          alt-speed-time-enabled = false;
          alt-speed-time-end = 1020;
          alt-speed-up = 50;
          bind-address-ipv4 = "0.0.0.0";
          bind-address-ipv6 = "::";
          blocklist-enabled = false;
          blocklist-url = "http://www.example.com/blocklist";
          cache-size-mb = 4;
          dht-enabled = true;
          download-dir = "/media/2TB_SSHD/transmission/completed";
          download-queue-enabled = true;
          download-queue-size = 5;
          encryption = 1;
          idle-seeding-limit = 30;
          idle-seeding-limit-enabled = false;
          incomplete-dir = "/media/2TB_SSHD/transmission/incomplete";
          incomplete-dir-enabled = true;
          lpd-enabled = false;
          message-level = 2;
          peer-congestion-algorithm = "";
          peer-id-ttl-hours = 6;
          peer-limit-global = 200;
          peer-limit-per-torrent = 50;
          peer-port = 51413;
          peer-port-random-high = 65535;
          peer-port-random-low = 65535;
          peer-port-random-on-start = false;
          peer-socket-tos = "default";
          pex-enabled = true;
          port-forwarding-enabled = true;
          preallocation = 1;
          prefetch-enabled = true;
          queue-stalled-enabled = true;
          queue-stalled-minutes = 30;
          ratio-limit = 2;
          ratio-limit-enabled = false;
          rename-partial-files = true;
          rpc-authentication-required = false;
          rpc-bind-address = "127.0.0.1";
          rpc-enabled = true;
          rpc-host-whitelist = "";
          rpc-host-whitelist-enabled = true;
          rpc-password = "{2e93d63a49829e77825102ad3a3f5fa927f5926btP0esoDS";
          rpc-port = 9091;
          rpc-url = "/transmission/";
          rpc-username = "";
          rpc-whitelist = "127.0.0.1;::1";
          rpc-whitelist-enabled = true;
          scrape-paused-torrents-enabled = true;
          script-torrent-done-enabled = false;
          #script-torrent-done-filename = "";
          seed-queue-enabled = false;
          seed-queue-size = 10;
          speed-limit-down = 100;
          speed-limit-down-enabled = false;
          speed-limit-up = 100;
          speed-limit-up-enabled = false;
          start-added-torrents = true;
          trash-original-torrent-files = false;
          umask = 2;
          upload-slots-per-torrent = 14;
          utp-enabled = true;
          watch-dir = "/media/2TB_SSHD/transmission/watch-dir";
          watch-dir-enabled = false;
        };
      };
    };

    home-manager.users.${user} = {
      home = {
        packages = with pkgs; [ transmission-remote-gtk ];
      };
    };

  };
}
