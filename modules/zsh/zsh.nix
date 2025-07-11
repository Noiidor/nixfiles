{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = rec {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    defaultKeymap = "emacs";

    shellAliases = {
      ls = "eza -a --icons=auto";
      ll = "eza -a --icons=auto -l -h";
      ff = "fastfetch";
      nv = "nvim";
      # yz = "yazi";
      kc = "kubectl";
      g = "git";
      gic = "git commit -am";
      gia = "git add .";
      gis = "git status";
      gidi = "git diff";
      gich = "git checkout";
      ai = "mods";
      lg = "lazygit";
      fuck = "thefuck";
      weather = "curl v2.wttr.in/Moscow";
      kubectx = "kubectl config use-context";
      watch = "viddy";
      grep = "grep --color=always";
      diff = "diff --color=always";
      ping = "gping";
      pping = "ping";
    };

    plugins = [
      {
        name = pkgs.zsh-fzf-tab.pname;
        src = pkgs.zsh-fzf-tab.src;
        file = "fzf-tab.plugin.zsh";
      }
      {
        name = pkgs.zsh-powerlevel10k.pname;
        src = pkgs.zsh-powerlevel10k.src;
        file = "powerlevel10k.zsh-theme";
      }
    ];

    history = {
      size = 5000;
      save = 5000;
      share = true;
      append = true;
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    initContent = ''
      bindkey "^R" history-incremental-pattern-search-backward
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down

      eval "$(fzf --zsh)"

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      autoload -U add-zsh-hook
    '';

    initExtra = lib.mkIf config.programs.foot.enable (builtins.readFile ./foot-zshrc);
  };
}
