{ lib, libcxxStdenv, cmake, pkg-config, fetchFromGitHub, libaaio, portaudio
, alsa-lib, jack2, autoPatchelfHook }:
let
  portaudioWithAlsaJack = portaudio.overrideAttrs (old: {
    configureFlags = old.configureFlags ++ [ "--with-alsa" "--with-jack" ];
    dontDisableStatic = true;
    outputs = [ "out" "dev" ];
  });
in libcxxStdenv.mkDerivation (self: {
  pname = "cdp8";
  version = "8.0";

  src = fetchFromGitHub {
    owner = "ComposersDesktop";
    repo = "CDP8";
    rev = "11cdcb4a6742f7ada1ded43e436a77a94d7c4ee4";
    hash = "sha256-zIwwnUqssU0hHN/6PlxtLcXF9YuZTfHkm61vpbUJ7Ko=";
  };

  nativeBuildInputs = [ cmake libaaio pkg-config autoPatchelfHook ];

  buildInputs = [ portaudioWithAlsaJack alsa-lib jack2 ];

  # Extract PortAudio source into CDP8 source tree,
  # as per building instructions found here:
  # https://github.com/ComposersDesktop/CDP8/blob/11cdcb4a6742f7ada1ded43e436a77a94d7c4ee4/dev/externals/paprogs/palinuxbuild.txt
  preConfigure = ''
    mkdir -p dev/externals
    tar -xf ${portaudioWithAlsaJack.src} -C dev/externals/ --strip-components=1
  '';

  cmakeFlags = [
    "-DAAIOLIB=${lib.getLib libaaio}/lib/libaaio.so"
    "-DPORTAUDIO_LIBRARY=${portaudioWithAlsaJack}/lib/libportaudio.so"
    "-DCMAKE_SKIP_RPATH=ON"
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
