{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Private expression, should at least setup necessary envs
    "${inputs.priv-env}/system-env.nix"
    ./darwin.nix
  ];

  environment.systemPackages = [];

  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  programs.zsh.enable = true;

  system.stateVersion = 4;

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
