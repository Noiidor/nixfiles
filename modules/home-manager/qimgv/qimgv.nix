{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    qimgv
  ];

  xdg.mimeApps.defaultApplications = let
    apps = {
      qimgv = ["image/png" "image/jpeg" "image/webp" "image/gif"];
    };
  in
    {}
    // (lib.genAttrs apps.qimgv (_: "qimgv.desktop"));

  xdg.configFile.qimgv = {
    recursive = true;
    source = ./.;
  };
}
