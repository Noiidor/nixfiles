{pkgs, ...}:
pkgs.runCommand "vrc-osd-cyr-font" {} ''
  mkdir -p $out/share/fonts/truetype
  ${pkgs.unzip}/bin/unzip ${./vcr-osd-cyr-font.zip} -d $out/share/fonts/truetype
''
