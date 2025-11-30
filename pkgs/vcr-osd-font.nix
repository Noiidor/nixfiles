{
  lib,
  stdenvNoCC,
  fetchzip,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "vcr-osd-font";
  version = "1.001";
  dontConfigure = true;
  src = fetchzip {
    url = "https://dl.dafont.com/dl/?f=vcr_osd_mono";
    sha256 = "sha256-6UrP5b0MUT+uoSOLzW4PwPNIst9el0ZMqhwz5BfFU+g=";
    extension = "zip";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/truetype/
  '';
  meta = {description = "VHS-style font";};
}
