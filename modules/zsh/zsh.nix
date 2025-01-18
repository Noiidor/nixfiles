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
      ez = "eza -a --icons=auto";
      ff = "fastfetch";
      nv = "nvim";
      yz = "yazi";
      kc = "kubectl";
      g = "git";
      gic = "git commit -am";
      gia = "git add .";
      gis = "git status";
      gid = "git diff";
    };

    enableVteIntegration = true;

    initExtra = ''
      PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
    '';
  };
}
