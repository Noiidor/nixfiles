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
    # mako # Notifoication daemon
    swww # Wallpapers utility
    rofi-wayland
    pwvucontrol # Volume control
    playerctl
    brightnessctl
    wlogout
    nautilus # File manager
    sushi # File previewer for Nautilus
    hyprpicker # Screen color picker
    kdePackages.xwaylandvideobridge
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

  systemd.user.services.reload-hypr = {
    Unit = {
      Description = "Reload Hyprland conf after rebuild";
      Documentation = ["man:hyprctl(1)"];
    };
    Service = {
      Type = "simple";
      ExecStart = "hyprctl reload";
      RemainAfterExit = true;
    };
    Install = {
      WantedBy = ["multi-user.target"];
    };
  };

  xdg.configFile.hypr = {
    recursive = true;
    source = ./.;
  };
}
