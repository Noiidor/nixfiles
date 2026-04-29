{pkgs, ...}: {
  users.users.noi = {
    isNormalUser = true;
    description = "noi";
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3vc5mJ3TAZy2q9P1ZkKkDquCMWw2EZPZpqfSlmZ4F3 noidor2019@gmail.com"
    ];
  };

  services.openssh = {
    enable = true;
    allowSFTP = false;
    ports = [22];
    settings = {
      LogLevel = "VERBOSE";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs = {
    zsh.enable = true;
    zoxide.enable = true;
  };

  environment.systemPackages = with pkgs; [
    unstable.neovim

    # Formatting
    biome # json, js
    yamlfmt
    alejandra

    fd
    ripgrep
    jq
    yq
    eza
    starship
    fzf
    tmux
    git
    go
  ];

  nix = {
    channel.enable = false;
    registry = {
      unstable = {
        from = {
          id = "unstable";
          type = "indirect";
        };
        to = {
          type = "github";
          owner = "NixOS";
          repo = "nixpkgs";
          ref = "nixos-unstable";
        };
      };
    };

    settings = {
      trusted-users = ["noi"];
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
  };
}
