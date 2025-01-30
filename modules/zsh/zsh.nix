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
      gidi = "git diff";
      gich = "git checkout";
      gipul = "git pull";
      gipus = "git push";
      ai = "mods";
    };

    enableVteIntegration = true;

    initExtra = ''
      PROMPT="%F{blue}%~ %(?.%F{green}.%F{red})%#%f "
    '';
  };
}
