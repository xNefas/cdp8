{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "libaaio";
  version = "0.3.1";

  src = fetchurl {
    url = "https://github.com/ComposersDesktop/CDP8/raw/456ffe0687c8d8206f8bc4e22273587db4c0ee0a/libaaio/libaaio-${version}.tar.bz2";
    hash = "sha256-H4oDCOinm7hSeznk5Bf17yd9g5Ub+szqaV1iwmtyFUQ=";
  };

  configurePhase = ''
    ls -la
    ./configure --prefix=$out
  '';

  sourceRoot = "${pname}-${version}";

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  meta = with lib; {
    description = "CDP8 Dependency - emulation of Windows keyboard functions (getch etc)";
    homepage = "https://github.com/ComposersDesktop/CDP8";
    license = licenses.lgpl21;
    platforms = platforms.linux;
  };
}
