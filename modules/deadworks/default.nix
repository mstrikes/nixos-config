{ stdenv
, dpkg
, autoPatchelfHook
, glib-networking
, openssl
, webkitgtk_4_1
, wrapGAppsHook4
, libayatana-appindicator    
, patchelf
}:

stdenv.mkDerivation {
  name = "deadworks-launcher";
  version = "0.4.1";

  src = ./Deadworks_0.4.1_amd64.deb;
  
  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    patchelf
  ];

  buildInputs = [
    glib-networking
    openssl
    webkitgtk_4_1
    wrapGAppsHook4
    libayatana-appindicator    
  ];

  unpackCmd = "dpkg-deb -x $curSrc source";
  installPhase = "mv usr $out";
  fixupPhase = "patchelf --add-needed ${libayatana-appindicator}/lib/libayatana-appindicator3.so.1 $out/bin/deadworks-launcher";
}
