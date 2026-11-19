{ stdenv
, dpkg
, autoPatchelfHook
, glib-networking
, openssl
, webkitgtk_4_1
, wrapGAppsHook4
, libayatana-appindicator    
}:

stdenv.mkDerivation {
  pname = "deadworks-launcher";
  version = "0.4.1";

  src = ./Deadworks_0.4.1_amd64.deb;
  
  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  buildInputs = [
    glib-networking
    openssl
    webkitgtk_4_1
    wrapGAppsHook4
    libayatana-appindicator    
  ];

  runtimeDependencies = [
    libayatana-appindicator
  ];

  installPhase = ''
    mkdir $out
    cp -r usr/* $out
  '';
}
