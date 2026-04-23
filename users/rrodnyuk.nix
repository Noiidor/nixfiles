{
  config,
  lib,
  pkgs,
  inputs,
  ...
} @ args: let
  dotfiles = import ../dotfiles/dotfiles.nix args;
in {
  imports = [
    "${inputs.home-manager-unstable}/modules/services/colima.nix"

    # inputs.agenix.homeManagerModules.default
  ];
  home.username = "rrodnyuk";
  home.homeDirectory = "/Users/rrodnyuk";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ghostty-bin
    tmux
    starship
    fzf # Zsh dep
    apple-sdk_26
    yazi
    xcode-install
    go
    gopls
    # go_1_24
    golangci-lint
    # grpc_cli # Unavailable
    kubectl
    kubectx
    vault
    grpcurl
    docker
    bat
    eza
    zoxide
    grpc
    protobuf
    pre-commit
    cobra-cli
    # rush # Broken
    poppler-utils # Dep for tests
    goose
    lazygit
    bruno
    gotools
    localsend
    go-minimock
    betterdisplay
    # unstable.claude-code
    glow
    pgcli
    delta
    ripgrep
    alejandra
    stylua # lua
    biome # json, js
    sleek # sql
    nixd

    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    inputs.zen-browser2.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.colima = {
    enable = true;
    package = pkgs.unstable.colima;
  };

  programs = {
    mpv = {
      enable = false;
      package = pkgs.unstable.mpv;
      # scripts = [pkgs.mpvScripts.uosc];
      config = {
        loop-file = "inf";
      };
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          # name = "";
          # email = "";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
      };
      pull = {
        rebase = false;
      };
    };
  };

  home.file = {
    ".config/yazi/yazi.toml".source = dotfiles.yazi.config;
    ".config/yazi/keymap.toml".source = dotfiles.yazi.keymap;
    ".config/yazi/theme.toml".source = dotfiles.yazi.theme;

    ".zshrc".source = dotfiles.zsh.config;

    ".config/starship.toml".source = dotfiles.starship.config;

    ".config/tmux/tmux.conf".source = dotfiles.tmux.config;

    ".config/nvim/init.lua".source = dotfiles.neovim.config;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
  ];

  programs.home-manager.enable = true;
}
