{user, ...}: {
  programs = {
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "Hardcore";
        font-family = "JetBraintsMono Nerd Font Mono";
        custom-shader = "/home/${user}/shader.glsl";
        gtk-titlebar = false;
      };
    };
  };
}
