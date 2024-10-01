{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  ...
}: let
  aagl = inputs.aagl;
in {
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/zsh/zsh.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages =
      (with pkgs; [
        kitty
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
        lazygit
      ])
      ++ [
        aagl.packages.${system}.the-honkers-railway-launcher
      ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
      "$HOME/go/bin"
    ];

    stateVersion = "24.05";
  };

  programs = {
    # honkers-railway-launcher.enable = true;

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
