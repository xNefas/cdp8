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
    url = "https://github.com/ComposersDesktop/CDP8/blob/main/libaaio/libaaio-0.3.1.tar.bz2";
    hash = "sha256-UkPSSVq0cjNuUyDIstavyjFuH2E4H0/yhJz5T/MRrnA=";
  };

  unpackPhase = ''
    tar -xjf $out
  '';

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
