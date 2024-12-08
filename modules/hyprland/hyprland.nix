{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
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
    nautilus
    sushi
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
}
