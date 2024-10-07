{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  ...
}: let
  aagl-pkgs = inputs.aagl.packages.${system};
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
      (with pkgs; [
        obsidian
        bruno
        spotify
        dbeaver-bin
        qbittorrent
        telegram-desktop
        vesktop
        lutris
        vscode
        postman
        obs-studio

        # Media
        mpc-qt
        gimp
        inkscape
        imv
        feh

        # TUI
        lazygit
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
      ])
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

  programs = {
    kitty.enable = true;

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
  };

  nixpkgs.config.allowUnfree = true;
}
