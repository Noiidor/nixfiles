{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  environment.systemPackages = [];

  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  # programs.zsh.enable = true;

  nix-homebrew = {
    enable = true;
    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    # enableRosetta = true;
    user = "rrodnyuk";
  };

  homebrew = {
    enable = true;
    brews = [
      "deskflow"
    ];
    taps =
      [
        "deskflow/tap"
      ]
      ++ builtins.attrNames config.nix-homebrew.taps;
  };

  system.stateVersion = 4;
  system.primaryUser = "rrodnyuk";

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
  ];

  environment.variables = {
    LANG = "en_US.UTF-8";
    EDITOR = "nvim";

    GONOPROXY = "";
    GONOSUMDB = "";
    GOPRIVATE = "";
    GOSUMDB = "off";
  };

  environment.systemPath = [
    "$HOME/.o3-cli/bin"
  ];

  nix = {
    enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
  };
}
