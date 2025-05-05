{
  lib,
  qtbase,
  qtsvg,
  qtgraphicaleffects,
  qtquickcontrols2,
  wrapQtAppsHook,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation
rec {
  pname = "experiments-lain-sddm";
  version = "0.9.1";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "lll2yu";
    repo = "sddm-lain-wired-theme";
    rev = "6bd2074ff0c3eea7979f390ddeaa0d2b95e171b7";
    sha256 = "14l65d2vljqmgn91h5q6kkxwicjzcdz9k49wpjhmdfqky9wwg5xb";
  };
  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  propagatedUserEnvPkgs = [
    qtbase
    qtsvg
    qtgraphicaleffects
    qtquickcontrols2
  ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/experiments-lain-sddm
  '';
}
