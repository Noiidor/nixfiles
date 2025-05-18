{
  vars,
  inputs,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    hyprland.enable = false;

    overwrite.enable = true;

    # theme = "rose_pine_moon";

    settings = {
      layout = {
        "bar.layouts" = {
          "0" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["media" "cava"];
            right = ["volume" "network" "bluetooth" "battery" "systray" "clock" "kbinput" "notifications"];
          };
          # "1" = {
          #   left = ["dashboard" "workspaces" "windowtitle"];
          #   middle = ["media"];
          #   right = ["volume" "clock" "notifications"];
          # };
          # "2" = {
          #   left = ["dashboard" "workspaces" "windowtitle"];
          #   middle = ["media"];
          #   right = ["volume" "clock" "notifications"];
          # };
        };
      };

      bar = {
        launcher = {
          autoDetectIcon = true;
        };

        media = {
          show_active_only = true;
          rightClick = "playerctl play-pause";
        };

        network = {
          label = false;
        };

        notifications = {
          show_total = true;
          hideCountWhenZero = true;
        };

        workspaces = {
          applicationIconOncePerWorkspace = true;
          showApplicationIcons = true;
          showWsIcons = true;
        };

        customModules = {
          cava = {
            bars = 12;
            showActiveOnly = true;
            showIcon = false;
            stereo = true;
          };
        };
      };

      notifications = {
        showActionsOnHover = true;
      };

      menus = {
        dashboard = {
          shortcuts.enabled = false;
        };

        media = {
          displayTimeTooltip = true;
        };

        power = {
          lowBatteryNotification = true;
          lowBatteryThreshold = 15;
        };

        clock = {
          time = {
            military = true;
          };
          weather = {
            unit = "metric";
          };
        };
      };

      theme = {
        name = "monochrome";
        bar = {
          scaling = 90;
          transparent = true;
          opacity = 70;

          buttons = {
            opacity = 90;
            radius = "0.6em";
            background_hover_opacity = 50;
            background_opacity = 40;

            windowtitle = {
              enableBorder = true;
            };

            modules = {
              # cava = {
              #   spacing = "0";
              # };
            };
          };

          menus = {
            card_radius = "0.6em";
            enableShadow = true;

            menu = {
              dashboard = {
                profile = {
                  radius = "0.6em";
                  size = "7.5em";
                };
              };

              power = {
                scaling = 100;
              };
            };

            popover = {
              # background = "#1a1a1a";
              radius = "0.6em";
            };
          };
        };

        notification = {
          enableShadow = true;
          opacity = 95;
        };

        osd = {
          enableShadow = true;
          opacity = 75;
          radius = "0.6em";
          scaling = 90;
        };

        font = {
          name = vars.fontName;
          size = "1.15rem";
        };
      };
    };

    override = {
      theme.bar.buttons.modules.cava.spacing = "0";
      theme.bar.menus.popover.background = "#1a1a1a";
      theme.bar.opacity = 70;
      theme.bar.buttons.background_opacity = 40;
      theme.font.name = vars.fontName;
      theme.font.label = vars.fontNameItalic;
      theme.font.style = "italic";
      theme.font.size = "1.15rem";
    };
  };
}
