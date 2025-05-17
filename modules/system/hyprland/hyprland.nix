{
  pkgs,
  inputs,
  ...
}: let
  # hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
  hyprlandPkgs = pkgs;
in {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  xdg.portal = {
    extraPortals = [
      hyprlandPkgs.xdg-desktop-portal-hyprland
    ];
  };

  services.udisks2 = {
    enable = true;
  };

  # system.userActivationScripts = {
  #   reloadHypr = {
  #     text = ''
  #       hyprctl reload
  #     '';
  #   };
  # };

  # environment.systemPackages = with pkgs; [
  #   mako # Notifoication daemon
  #   swww # Wallpapers utility
  #   rofi-wayland
  #   pwvucontrol # Volume control
  #   playerctl
  #   brightnessctl
  #   wlogout
  #   nautilus # File manager
  #   sushi # File previewer for Nautilus
  #   hyprpicker # Screen color picker
  #   xwaylandvideobridge
  #   overskride # Bluetooth GUI
  #   udiskie # Udisks GUI for removable drives
  #   ags
  #   hyprshot # Screenshot utility
  #   grim # Screenshot utility
  #   slurp # Screen selection util
  #   # hyprshade # Screen shader util
  #   networkmanagerapplet
  #   hyprcursor
  # ];
}
