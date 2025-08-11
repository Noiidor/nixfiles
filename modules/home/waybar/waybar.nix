{pkgs, ...}: {
  programs.waybar = {
    enable = true;
  };

  xdg.configFile.waybar = {
    recursive = true;
    source = ./.;
  };
}
