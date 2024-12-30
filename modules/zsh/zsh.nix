{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ez = "eza -la --icons=auto";
      ff = "fastfetch";
      nv = "nvim";
      yz = "yazi";
    };

    enableVteIntegration = true;

    initExtra = ''
      PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
    '';
  };
}
