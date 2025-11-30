{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mako # Notification daemon
    swww # Wallpapers utility
    rofi-wayland
    playerctl
    brightnessctl
    wlogout
    nautilus # File manager
    sushi # File previewer for Nautilus
    kdePackages.xwaylandvideobridge
    overskride # Bluetooth GUI
    grim # Screenshot utility
    slurp # Screen selection util
  ];

  services.udisks2 = {
    enable = true;
  };

  # services = {
  #   udiskie = {
  #     enable = true;
  #   };
  # };
}
