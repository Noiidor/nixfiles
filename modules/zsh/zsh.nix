{
  config,
  pkgs,
  pkgs-unstable,
}: {
  programs.zsh = {
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
      nv = "nvim";
    };

    enableVteIntegration = true;

    initExtra = ''
      PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
    '';
  };
}
