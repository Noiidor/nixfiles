{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    mako
    swww
    rofi-wayland
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];
}
