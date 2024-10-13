{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  aagl-pkgs = inputs.aagl.packages.${pkgs.system};
in {
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/zsh/zsh.nix
    ./modules/stylix/stylix.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages =
      # Stable packages
      (with pkgs; [
        # Work
        bruno
        dbeaver-bin
        vscode
        postman

        # Applications and gaming
        lutris
        vesktop
        telegram-desktop
        # spotify
        qbittorrent
        obsidian
        bottles
        mangohud

        # Media
        mpc-qt
        gimp
        inkscape
        imv
        feh
        obs-studio

        # TUI
        lazygit
        lazydocker
        pspg

        # CLI utils
        cbonsai
        lux
        cava
        pgcli
        eza
        bat
        sl
        cmatrix
        aalib
        fzf
      ])
      # Unstable packages
      ++ (with pkgs-unstable; [
        # Work

        # Applications and gaming

        # Media

        # TUI

        # CLI utils
        buf
      ])
      # Other
      ++ [
        aagl-pkgs.the-honkers-railway-launcher
      ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
      "$HOME/go/bin"
    ];

    sessionVariables = {
      PSQL_PAGER = "pspg -X";
    };

    stateVersion = "24.05";
  };

  programs = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    kitty.enable = true;
    zoxide.enable = true;

    firefox.enable = true;

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        copyToClipboard
        betterGenres
        autoSkip
        fullAppDisplay
        keyboardShortcut
        songStats
      ];
      enabledCustomApps = with spicePkgs.apps; [
        ncsVisualizer
      ];
      theme = spicePkgs.themes.comfy;
      colorScheme = "hikari";
    };

    mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.uosc];
    };

    htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };

    btop.enable = true;

    git = {
      enable = true;
      userName = "noi";
      userEmail = "noidor2019@gmail.com";
      extraConfig = {
        init.defaultBranch = "master";

        url = {
          "git@gitlab.com:" = {
            insteadOf = [
              "https://gitlab.com/"
            ];
          };
        };
      };
    };

    home-manager.enable = true;
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = "imv.desktop";
    "image/jpeg" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/gif" = "mpv.desktop";
    "video/mp4" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/mkv" = "mpv.desktop";
  };

  nixpkgs.config.allowUnfree = true;
}
