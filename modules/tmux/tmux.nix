{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "$SHELL";
    clock24 = true;
    # keyMode = "vi";
    prefix = "M-Space";
    baseIndex = 1;
    escapeTime = 5;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      # {
      #   plugin = dracula;
      #   extraConfig = ''
      #     set -g @dracula-show-battery false
      #     set -g @dracula-refresh-rate 10
      #     set -g @dracula-show-left-icon 󱄅
      #   '';
      # }
    ];
    extraConfig = ''
      set -g mouse on

      set -g status-position top

      set -g default-terminal "screen-256color"
      set -g status-bg colour236
      set -g status-fg colour241

      set -g @resurrect-strategy-nvim "session"
    '';
  };
}
