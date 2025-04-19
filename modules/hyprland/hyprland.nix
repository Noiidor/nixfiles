{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  xdg.portal = {
    extraPortals = [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };

  environment.systemPackages = with pkgs; [
    mako # Notifoication daemon
    swww # Wallpapers utility
    rofi-wayland
    pwvucontrol # Volume control
    playerctl
    brightnessctl
    wlogout
    nautilus # File manager
    sushi # File previewer for Nautilus
    hyprpicker # Screen color picker
    xwaylandvideobridge
    overskride # Bluetooth GUI
    udiskie # Udisks GUI for removable drives
    udisks
    ags
    hyprshot # Screenshot utility
    grim # Screenshot utility
    slurp # Screen selection util
    # hyprshade # Screen shader util
    networkmanagerapplet
    hyprcursor
  ];
}
