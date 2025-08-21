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
      set -a terminal-features "tmux-256color:RGB"
      set -g default-terminal "xterm-256color"
      set -g mouse on
      set -g renumber-windows on
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style "fg=default,bg=default"

      set -g @resurrect-strategy-nvim "session"

      bind-key -n M-1 select-window -t 1
      bind-key -n M-2 select-window -t 2
      bind-key -n M-3 select-window -t 3
      bind-key -n M-4 select-window -t 4
      bind-key -n M-5 select-window -t 5
      bind-key -n M-6 select-window -t 6
      bind-key -n M-7 select-window -t 7
      bind-key -n M-8 select-window -t 8
      bind-key -n M-9 select-window -t 9
    '';
  };
}
