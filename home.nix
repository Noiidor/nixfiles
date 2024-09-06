{ config, pkgs, ... }: 

{
  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages = with pkgs; [
      kitty
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
        rebuild = "sudo nixos-rebuild switch --flake ~/nixfiles";
        home-rebuild = "home-manager switch --flake ~/nixfiles";
        nixconf = "nvim ~/nixfiles/configuration.nix";
        homeconf = "nvim ~/nixfiles/home.nix";
        flakeconf = "nvim ~/nixfiles/flake.nix";
      };

      enableVteIntegration = true;

      initExtra = ''
	PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
      '';
    };

    neovim = {
      defaultEditor = true;
    };

    kitty = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "noi";
      userEmail = "noidor2019@gmail.com";
      extraConfig = {
        init.defaultBranch = "master";
      };
    };

    bruno.enable = true;

    home-manager.enable = true;   
  };

}
