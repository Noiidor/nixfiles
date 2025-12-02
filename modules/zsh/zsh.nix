{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableLsColors = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    vteIntegration = true;

    histSize = 10000;

    shellAliases = {
      ls = "eza -a --icons=auto";
      ll = "eza -a --icons=auto -l -h";
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
      lg = "lazygit";
      fuck = "thefuck";
      weather = "curl v2.wttr.in/Moscow";
      kubectx = "kubectl config use-context";
      watch = "viddy";
      grep = "grep --color=always";
      diff = "diff --color=always";
    };
    autosuggestions = {
      enable = true;
      strategy = ["history" "completion"];
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };
  };
}
