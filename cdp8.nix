{ lib, stdenv, cmake, pkg-config, fetchFromGitHub, libaaio, portaudio, alsa-lib
, jack2, }:
stdenv.mkDerivation (self: {
  pname = "cdp8";
  version = "8.0";

  src = fetchFromGitHub {
    owner = "ComposersDesktop";
    repo = "CDP8";
    rev = "CDP${self.version}";
    hash = "sha256-/L0ncIcB0OardDykhNHwJ3ae09Sh4iNOQSZRgNV7ZPQ=";
  };

  nativeBuildInputs = [ cmake libaaio pkg-config ];

  buildInputs = [
    (portaudio.overrideAttrs (old: {
      configureFlags = old.configureFlags
        ++ [ "--enable-static" "--with-alsa" "--with-jack" ];
    }))
    alsa-lib
    jack2
  ];

  cmakeFlags = [
    "-DAAIOLIB=${lib.getLib libaaio}/lib/libaaio.so"
    "-DPORTAUDIOLIB=${portaudio}/lib/libportaudio.a" # CDP expects static library
  ];

  meta = {
    description = "CDP8 audio processing toolkit";
    maintainers = [ lib.maintainers.enkarterisi ];
    homepage = "https://www.composersdesktop.com/";
    license = lib.licenses.lgpl21;
    platforms = lib.platforms.linux;
    mainProgram = "cdp8";
  };
})
