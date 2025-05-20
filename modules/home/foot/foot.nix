{user, lib, ...}: {
  programs = {
    foot = {
      enable = true;
      # enableZshIntegration = true;
      settings = {
        main = {
          term = "xterm-256color";
          gamma-correct-blending = "no";
        };
        cursor = {
          style = "beam";
          unfocused-style = "hollow";
          blink = "yes";
        };
        colors = {
            alpha = lib.mkForce 0.9;
        };
        tweak = {
          overflowing-glyphs = "yes";
        };
      };
    };
  };
}
