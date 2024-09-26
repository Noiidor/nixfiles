{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/zsh/zsh.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages = with pkgs; [
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
    ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
      "$HOME/go/bin"
    ];

    stateVersion = "24.05";
  };

  programs = {
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   autosuggestion.enable = true;
    #   syntaxHighlighting.enable = true;
    #   shellAliases = {
    #     ll = "ls -l";
    #     ff = "fastfetch";
    #     nix-rebuild = "sudo nixos-rebuild switch --flake ~/nixfiles";
    #     home-rebuild = "home-manager switch --flake ~/nixfiles";
    #     nixconf = "$EDITOR ~/nixfiles/configuration.nix";
    #     homeconf = "$EDITOR ~/nixfiles/home.nix";
    #     flakeconf = "$EDITOR ~/nixfiles/flake.nix";
    #     nv = "nvim";
    #   };
    #
    #   enableVteIntegration = true;
    #
    #   initExtra = ''
    #     PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
    #   '';
    # };

    # tmux = {
    #   enable = true;
    #   shell = "$SHELL";
    #   clock24 = true;
    #   keyMode = "vi";
    # }

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
