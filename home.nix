{
  config,
  pkgs,
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
    ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
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
      defaultEditor = true;
    };

    git = {
      enable = true;
      userName = "noi";
      userEmail = "noidor2019@gmail.com";
      extraConfig = {
        init.defaultBranch = "master";
      };
    };

    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
