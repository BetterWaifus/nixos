{ pkgs, user, lib, config, ... }:
{
  config = {
    nixpkgs.overlays = [
      (self: super: {
        parsec-bin = with super; super.parsec-bin.overrideAttrs (old: {
          runtimeDependenciesPath = lib.makeLibraryPath [
            alsaLib
            cups
            dbus
            # debExtract
            fontconfig
            freetype
            libGL
            libpulseaudio
            libsamplerate
            udev
            libva
            libxkbcommon
            nas
            stdenv.cc.cc.lib
            vulkan-loader
            openssl
            ffmpeg_4
            xorg.libX11
            xorg.libXScrnSaver
            xorg.libXcursor
            xorg.libXext
            xorg.libXi
            xorg.libXinerama
            xorg.libXrandr
            xorg.libXrender
            xorg.libXxf86vm
            xorg.libxcb
            # wayland
            # gnome.zenity
            # xorg.xhost
          ];
        });
      })
    ];
  };
}
