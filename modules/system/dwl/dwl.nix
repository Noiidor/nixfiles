{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (dwl.overrideAttrs (oldAttrs: rec {
      patches = [
        (pkgs.fetchpatch {
          url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/bar/bar-0.7.patch";
          hash = "sha256-b5DQ4lyBYTlZsjbpbVw8ZXzhBRuEgnDjHyPGW5Cy80M=";
        })
        (pkgs.fetchpatch {
          url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/barpadding/barpadding.patch";
          hash = "sha256-8XqaiZk64XLodPx/fnNurhpBUoBeFZRImDGuklCO2Ac=";
        })
      ];
      buildInputs =
        oldAttrs.buildInputs
        ++ [
          fcft
          pixman
          libdrm
        ];
    }))
  ];
}
