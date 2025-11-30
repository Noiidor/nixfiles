{pkgs, ...}: {
  config = (pkgs.formats.iniWithGlobalSection {}).generate "foot-config" {
    globalSection = {
    };

    sections = {
      main = {
        term = "xterm-256color";
        title = "Terminal";
        gamma-correct-blending = "no";
        font = "Maple Mono NF CN:size=16";
      };
      cursor = {
        style = "beam";
        unfocused-style = "hollow";
        blink = "yes";
      };
      colors = {
        alpha = 0.9;
      };
      tweak = {
        overflowing-glyphs = "yes";
      };
    };
  };
}
