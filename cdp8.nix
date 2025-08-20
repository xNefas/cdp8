{
  lib,
  stdenv,
  cmake,
  pkg-config,
  fetchFromGitHub,
  libaaio,
  ...
}:
stdenv.mkDerivation rec {
  pname = "cdp8";
  version = "8.0";

  src = fetchFromGitHub {
    owner = "ComposersDesktop";
    repo = "CDP8";
    rev = "CDP${version}";
    hash = "sha256-/L0ncIcB0OardDykhNHwJ3ae09Sh4iNOQSZRgNV7ZPQ=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  cmakeFlags = [
    "-DAAIOLIB=${lib.getLib libaaio}/lib/libaaio.so"
  ];

  cmakeBuildDir = "source/build";

  installPhase = ''
    runHook preInstall

    # Install CDP8 binaries
    mkdir -p $out/bin
    cp -t $out/bin source/build/NewRelease/*

    runHook postInstall
  '';

  meta = with lib; {
    description = "CDP8 audio processing toolkit";
    maintainers = with maintainers; [enkarterisi];
    homepage = "https://www.composersdesktop.com/";
    license = licenses.lgpl21;
    platforms = platforms.linux;
    mainProgram = "cdp8";
  };
}
