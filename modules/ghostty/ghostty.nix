{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  programs = {
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "Hardcore";
        font-family = "JetBraintsMono Nerd Font Mono";
        custom-shader = "/home/noi/shader.glsl";
        gtk-titlebar = false;
      };
    };
  };

  # xdg.configFile.ghostty = {
  #   recursive = true;
  #   source = ./.;
  # };
}
