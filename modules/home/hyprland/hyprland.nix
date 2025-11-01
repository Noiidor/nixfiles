{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../desktop/desktop.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = null;
    portalPackage = null;
  };

  home.packages = with pkgs; [
    hyprpicker # Screen color picker
    hyprshot # Screenshot utility
    hyprcursor
    hyprland-per-window-layout
    # hyprshade # Screen shader util
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

  # xdg.configFile.hypr = {
  #   recursive = true;
  #   source = pkgs.replaceVarsWith {
  #     src = ./hyprland.conf;
  #     replacements = {round = 10;};
  #     dir = ".";
  #   };
  # };

  xdg.configFile.hypr = {
    source = ./.;
    recursive = true;
  };
}
