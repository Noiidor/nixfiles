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
        mpc-qt
        lutris
        vscode
        postman
        gimp
        inkscape
        obs-studio

        # TUI
        lazygit
        pspg

        # CLI utils
        cbonsai
        lux
        cava
        pgcli
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

  nixpkgs.config.allowUnfree = true;
}
