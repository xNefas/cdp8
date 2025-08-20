{
  lib,
  stdenv,
  fetchurl,
  portaudio,
  pkg-config,
  autoreconfHook,
}:
stdenv.mkDerivation rec {
  pname = "paprogs";
  version = "0.3.1";

  src = fetchurl {
    url = "https://github.com/ComposersDesktop/CDP8/raw/456ffe0687c8d8206f8bc4e22273587db4c0ee0a/libaaio/libaaio-${version}.tar.bz2";
    hash = "sha256-H4oDCOinm7hSeznk5Bf17yd9g5Ub+szqaV1iwmtyFUQ=";
  };

  sourceRoot = "${pname}-${version}";

  nativeBuildInputs = [
    portaudio
    pkg-config
    autoreconfHook
  ];

  meta = with lib; {
    description = "CDP8 Dependency - emulation of Windows keyboard functions (getch etc)";
    homepage = "https://github.com/ComposersDesktop/CDP8";
    license = licenses.lgpl21;
    platforms = platforms.linux;
  };
}
