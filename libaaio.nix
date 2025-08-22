{ lib, stdenv, fetchurl, pkg-config, autoreconfHook, }:
stdenv.mkDerivation rec {
  pname = "libaaio";
  version = "0.3.1";

  src = fetchurl {
    url =
      "https://github.com/ComposersDesktop/CDP8/raw/456ffe0687c8d8206f8bc4e22273587db4c0ee0a/libaaio/libaaio-${version}.tar.bz2";
    hash = "sha256-H4oDCOinm7hSeznk5Bf17yd9g5Ub+szqaV1iwmtyFUQ=";
  };

  sourceRoot = "${pname}-${version}";

  nativeBuildInputs = [ pkg-config autoreconfHook ];

  meta = with lib; {
    description =
      "Lightweight Unix library providing Windows-style console I/O functions";
    longDescription = ''
      A portable implementation of Windows-style console input functions for Unix-like systems.
      Provides non-blocking keyboard input (getch, getche, kbhit) without requiring terminal
      initialization like curses/ncurses. Maintains terminal state integrity by preserving
      and restoring settings during operations.

      Designed as a lightweight alternative for applications needing simple console interaction
      without full terminal management capabilities.
    '';
    homepage = "https://github.com/ComposersDesktop/CDP8";
    # Custom BSD-style license with attribution requirements (see aaio.h for full terms)
    license = licenses.bsdOriginal;
    maintainers = [ lib.maintainers.enkarterisi ];
    # Copyright holder information from aaio.h:
    # Copyright (c) 2004-2005 by Daniel Aarno - <macbishop@users.sf.net>
    # M. Sc. Electrical Engineering * http://www.nada.kth.se/~bishop
    platforms = platforms.linux;
  };
}
