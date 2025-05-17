{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = null;
    portalPackage = null;
  };

  home.packages = with pkgs; [
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
    ags
    hyprshot # Screenshot utility
    grim # Screenshot utility
    slurp # Screen selection util
    # hyprshade # Screen shader util
    networkmanagerapplet
    hyprcursor
  ];

  xdg.configFile.hypr = {
    recursive = true;
    source = ./.;
  };
}
