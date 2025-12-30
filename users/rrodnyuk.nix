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
    ../modules/home-manager-deprecated/nvim/nvim.nix
    "${inputs.home-manager-unstable}/modules/services/colima.nix"

    # Private expression, should at least setup git
    "${inputs.priv-env}/home-env.nix"

    # inputs.agenix.homeManagerModules.default
  ];
  home.username = "rrodnyuk";
  home.homeDirectory = "/Users/rrodnyuk";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    iterm2
    ghostty-bin
    tmux
    starship
    fzf # Zsh dep
    apple-sdk_26
    yazi
    xcode-install
    # go
    go_1_24
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
  ];

  services.colima = {
    enable = true;
  };

  home.file = {
    ".config/yazi/yazi.toml".source = dotfiles.yazi.config;
    ".config/yazi/keymap.toml".source = dotfiles.yazi.keymap;
    ".config/yazi/theme.toml".source = dotfiles.yazi.theme;

    ".zshrc".source = dotfiles.zsh.config;

    ".config/starship.toml".source = dotfiles.starship.config;

    ".config/tmux/tmux.conf".source = dotfiles.tmux.config;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
  ];

  programs.home-manager.enable = true;
}
