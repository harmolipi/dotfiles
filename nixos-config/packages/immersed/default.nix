{ lib
, appimageTools
, callPackage
, fetchurl
, stdenv
, pkgs
}:
let
  pname = "immersed";
  version = "10.5.0";
  system = "x86_64-linux";

  src = fetchurl {
    url = "https://static.immersed.com/dl/Immersed-x86_64.AppImage";
    hash = "sha256-u07QpGXEXbp7ApZgerq36x+4Wxsz08YAruIVnZeS0ck=";
  };

  extraPkgs = pkgs: with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gstreamermm
    gst_all_1.gst-vaapi
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-rs
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-base
    pipewire
    vaapiVdpau
    vaapiIntel
    amdvlk
    libvdpau-va-gl
    libva-utils
    libva
    mesa
    libva-minimal
    libva1-minimal
    libva1
    intel-media-driver
    libdrm
    linuxPackages.v4l2loopback
    v4l-utils
    libv4l
    wayland
    wayland-utils
    gdk-pixbuf
    gdk-pixbuf-xlib
    glib
    glib-networking
    gtk3
    libcanberra-gtk3
    libcanberra
  ];

  meta = with lib; {
    description = "A VR coworking platform";
    homepage = "https://immersed.com";
    license = licenses.unfree;
    maintainers = with maintainers; [ haruki7049 ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
in
appimageTools.wrapType2 rec {
  inherit pname version src meta;
  name = "${pname}-${version}";
}
