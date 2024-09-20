{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
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
    ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
      "$HOME/go/bin"
    ];

    stateVersion = "24.05";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        ff = "fastfetch";
        nix-rebuild = "sudo nixos-rebuild switch --flake ~/nixfiles";
        home-rebuild = "home-manager switch --flake ~/nixfiles";
        nixconf = "$EDITOR ~/nixfiles/configuration.nix";
        homeconf = "$EDITOR ~/nixfiles/home.nix";
        flakeconf = "$EDITOR ~/nixfiles/flake.nix";
      };

      enableVteIntegration = true;

      initExtra = ''
        PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
      '';
    };

    neovim = {
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      defaultEditor = true;
    };

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
