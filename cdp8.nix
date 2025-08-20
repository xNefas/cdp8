{
  lib,
  stdenv,
  system,
  cmake,
  pkg-config,
  fetchFromGitHub,
  libaaio ? ((import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/32f313e49e42f715491e1ea7b306a87c16fe0388.tar.gz";
      sha256 = "sha256:1z4ga87qla5300qwib3dnjnkaywwh8y1qqsb8w2mrsrw78k9xmlw";
    }) {
      inherit system;
    }).callPackage
  ./libaaio.nix {}),
  ...
}:
stdenv.mkDerivation rec {
  pname = "cdp8";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "ComposersDesktop";
    repo = "CDP8";
    rev = "CDP8.0";
    hash = "sha256-/L0ncIcB0OardDykhNHwJ3ae09Sh4iNOQSZRgNV7ZPQ=";
  };

  sourceRoot = "${pname}-${version}";

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
    cp -t $out/bin source/build/Release/*

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
