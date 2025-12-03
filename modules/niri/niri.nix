{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../desktop.nix
  ];

  environment.systemPackages = [
    inputs.xwayland-sattelite.packages.${pkgs.stdenv.hostPlatform.system}.default
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
