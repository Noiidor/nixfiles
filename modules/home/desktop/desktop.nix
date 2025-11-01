{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    mako # Notification daemon
    swww # Wallpapers utility
    rofi-wayland
    # pwvucontrol # Volume control
    playerctl
    brightnessctl
    wlogout
    nautilus # File manager
    sushi # File previewer for Nautilus
    kdePackages.xwaylandvideobridge
    overskride # Bluetooth GUI
    ags
    grim # Screenshot utility
    slurp # Screen selection util
    networkmanagerapplet
  ];

  services = {
    udiskie = {
      enable = true;
    };
  };
}
