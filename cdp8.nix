{
  lib,
  stdenv,
  cmake,
  pkg-config,
  fetchFromGitHub,
  libaaio ? ((import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/32f313e49e42f715491e1ea7b306a87c16fe0388.tar.gz") {}).callPackage ./libaaio.nix {}),
  ...
}: let
  cdp8 = fetchFromGitHub {
    owner = "ComposersDesktop";
    repo = "CDP8";
    rev = "CDP8.0";
    hash = "sha256-L0ncIcB0OardDykhNHwJ3ae09Sh4iNOQSZRgNV7ZPQ";
  };
in
  stdenv.mkDerivation {
    pname = "cdp8";
    version = "8.0.0";

    src = cdp8;

    nativeBuildInputs = [
      pkg-config
      cmake
    ];

    postUnpack = ''
      # Extract libaaio source into libaaio subdirectory
      tar xzf ${libaaio.src} -C $sourceRoot/libaaio --strip-components=1
    '';

    cmakeFlags = [
      "-DAAIOLIB=${libaaio}/lib/libaaio.so"
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
      license = licenses.lgpl21Only;
      platforms = platforms.linux;
      mainProgram = "cdp8";
    };
  }
