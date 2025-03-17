{pkgs, ...}: {
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
    ];
    extraConfig = ''
      set -g mouse on

      set -g status-position top

      set -g default-terminal "xterm-ghostty"

      set -g @resurrect-strategy-nvim "session"
    '';
  };
}
