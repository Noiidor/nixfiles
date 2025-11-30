{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../desktop.nix
  ];
  programs.niri.enable = true;
  programs.hyprlock.enable = true;

  xdg.portal = {
    enable = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
    };
  };
}
