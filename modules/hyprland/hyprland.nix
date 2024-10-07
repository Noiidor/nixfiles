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
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    mako
    swww
    rofi-wayland
    pavucontrol
    pwvucontrol
    playerctl
    brightnessctl
    wlogout
    gnome.nautilus
    gnome.sushi
    hyprpicker
    xwaylandvideobridge
    overskride
    udiskie
    ags
    hyprshot
    hyprshade
    networkmanager_dmenu
    grim
    slurp
    dmenu
    helvum
    networkmanagerapplet
    iniparser
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];
}
