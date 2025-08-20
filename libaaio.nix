{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  cmake,
  ...
}:
stdenv.mkDerivation rec {
  pname = "libaaio";
  version = "8.0.0";

  src = fetchurl {
    url = "https://github.com/ComposersDesktop/CDP8/raw/456ffe0687c8d8206f8bc4e22273587db4c0ee0a/libaaio/libaaio-0.3.1.tar.bz2";
    hash = "sha256-tnuRgquD2kpQu/wu+HncrF1jbOhoYKMU+jNuQZq6LFE=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  configureFlags = [
    "--prefix=$out"
  ];

  meta = with lib; {
    description = "CDP8 Dependency - emulation of Windows keyboard functions (getch etc)";
    homepage = "https://github.com/ComposersDesktop/CDP8";
    license = licenses.lgpl21;
    platforms = platforms.linux;
  };
}
